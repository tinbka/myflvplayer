class Video < ActiveRecord::Base
  
  def self.add(name, file)
    md5 = Digest::MD5.file(file.path).to_s
    if found = first(:conditions=>{:md5=>md5})
      return create found.to_hash.slice(*%w{
      thumb_path path fullpath duration width height md5
    }).merge!(:name => name)
    end
    filename = "%d%03d_%s.flv"%[Time.now, rand(1000), name.tr('"', "'").squeeze('.')]
    
    info = `#{G[:encoder_info]%file.path}`
    if !(video_info = info.match(/Video: (\w+),.+ (\d+)x(\d+)/)) or
                          !(duration = info.match(/Duration: ([\d:]+)/i))
      return "Can't get video info, file is corrupted or of invalid format" 
    end
    if G[:max_duration] and duration[1].scanf('%d:%d:%d').reduce {|m,i| m*60+i} > G[:max_duration]
      return "Video is too long, duration limit is #{G[:max_duration]} seconds"
    end
    
    codec = video_info[1]
    dims = video_info[2..3].map &:to_i
    w, h = [dims, dims.scale(G[:max_video_resolution])].min
    path = '/files/video/'+filename
    fullpath = File.expand_path 'public'+path
    if [w, h] == dims and codec == 'flv'
      File.rename(file.path, fullpath)
    else
      output = `#{G[:encoder_run]%[file.path, w, h, fullpath]}`
      return output[/.+\Z/] if $?.exitstatus != 0
    end
    
    video = new :name=>name, :path=>path, :duration=>duration[1], :width=>w, :height=>h, :fullpath=>fullpath, :md5 => md5
    video.make_thumbnail(filename).save
    video
  end
  
  def make_thumbnail(filename)
    self.thumb_path = '/thumb/'+filename.sub(/\.\w+$/, '.jpg')
    dims = [width, height]
    w, h = [dims, dims.scale(120)].min
    `#{G[:encoder_thumb]%[fullpath, w, h, 'public'+thumb_path]}`
    self
  end

  def get_fileinfo
    "#{duration}, #{width}×#{height}"
  end
  
end

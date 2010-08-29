class VideosController < ApplicationController

  def index
    @videos = Video.all :limit=>10, :order=>'id desc'
    @video = Video.new
  end

  def show
    @video = Video.find(params[:id])
    @path = File.join(File.dirname(@video.path), CGI.escape(File.basename(@video.path)))
  end

  def create
    name = params[:name].to_s.
                sub(/^$/, File.basename(params[:file].original_filename).match(/(.+)\./)[1])
    result = Video.add(name, params[:file])
    if result.is_a? String
      flash[:fail] = result
      redirect_to videos_url
    else
      flash[:success] = "#{result.name} was successfully uploaded and encoded."
      redirect_to result
    end
  end
  
end

class CreateVideos < ActiveRecord::Migration
  def self.up
    create_table :videos do |t|
      t.string :path
      t.string :fullpath
      t.string :thumb_path
      t.string :name
      
      t.integer :width
      t.integer :height
      t.string :duration
      t.string :md5

      t.timestamps
    end
  end

  def self.down
    drop_table :videos
  end
end

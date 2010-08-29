# Be sure to restart your server when you modify this file

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.3.5' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|

  config.time_zone = 'UTC'
  config.i18n.default_locale = :ru
  
end

require File.join(RAILS_ROOT, 'lib/requirements.rb')

G = {
  # %[escaped input]
  :encoder_info => 'ffmpeg -i "%s" 2>&1',
  # %[escaped input, width, height, escaped output]
  :encoder_run => 'ffmpeg -i "%s" -s %dx%d -ar 22050 "%s" 2>&1',
  :encoder_thumb => 'ffmpeg -itsoffset -2 -i "%s" -vcodec mjpeg -vframes 1 -an -f rawvideo -s %dx%d "%s" 2>/dev/null',
  :max_duration => 600,
  :max_video_resolution => [500, 324]
}


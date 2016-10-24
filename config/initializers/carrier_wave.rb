require 'carrierwave'
require 'carrierwave/orm/activerecord'

CarrierWave.configure do |config|
  config.fog_credentials = {
    # Configuration for amazon s3
    provider: 'AWS',
    aws_access_key_id: ENV['aws_access_id'],
    aws_secret_access_key: ENV['aws_secret_key'],
    region: 'us-east-1'
  }
  config.fog_directory = ENV['aws_s3_bucket']
  config.fog_public = false
  config.cache_dir = "#{Rails.root}/tmp/uploads"
end
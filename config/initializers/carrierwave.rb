require 'carrierwave/storage/abstract'
require 'carrierwave/storage/file'
require 'carrierwave/storage/fog'

CarrierWave.configure do |config|
  if Rails.env.production?
    config.storage = :fog
    config.fog_provider = 'fog/aws'
    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: Rails.application.credentials.aws[:access_key_id],
      aws_secret_access_key: Rails.application.credentials.aws[:secret_access_key],
      region: 'ap-northeast-1'
    }
    config.fog_directory = Rails.application.credentials.aws[:s3_bucket_name]
    config.asset_host = Rails.application.credentials.aws[:s3_host] 
    # config.fog_directory  = 'tiphp452-pfc-com'
    # config.asset_host = 'https://s3-ap-northeast-1.amazonaws.com/tiphp452-pfc-com'  
  else
    config.storage :file
    config.enable_processing = false if Rails.env.test?
  end
end
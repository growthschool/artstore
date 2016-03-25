CarrierWave.configure do |config|
  if Rails.env.production?
    config.storage :fog
    config.fog_credentials = {
      provider:              'AWS',
      aws_access_key_id:     ENV['S3_key_id'],
      aws_secret_access_key: ENV['S3_key_secret'],
      region:                'ap-southeast-1'
    }
    config.fog_directory = 'francis-bucket'

  else
    config.storage :file
  end

end

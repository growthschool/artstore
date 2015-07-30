CarrierWave.configure do |config|
  if Rails.env.production?
    config.fog_credentials = {
      provider:               'AWS',
      aws_access_key_id:      ENV["S3_ID"],
      aws_secret_access_key:  ENV["S3_SECRET"],
      region:                 'us-west-2'
    }
    config.fog_directory =    'forphoto'
  else
    config.storage :file
  end
end
CarrierWave.configure do |config|
  if Rails.env.production?
    config.fog_provider = 'fog/aws'
    config.fog_credentials = {
      provider:              'AWS',
      aws_access_key_id:     'AKIAIITTWKULZYWUXOZQ',      # 你的 key
      aws_secret_access_key: 'BEZdBWkvcFhpZQXcUQYX9O0UkOcXlS4JaedImYvZ',      # 你的 secret key
      region:                'us-west-2' # 你的 S3 bucket 的 Region 位置
    }
    config.fog_directory  = 'artstore-class' # 你設定的 bucket name
  else
    config.storage :file
  end
end

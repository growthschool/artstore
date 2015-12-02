CarrierWave.configure do |config|
   if Rails.env.production?
    config.storage :fog
    config.fog_credentials = {
      provider:              'AWS',
      aws_access_key_id:     ENV['aws_key'],      # 你的 key

      aws_secret_access_key: ENV['aws_secret'],      # 你的 secret key

      region:                'us-west-1' # 你的 S3 bucket 的 Region 位置

    }
    config.fog_directory  = 'artstore01' # 你設定的 bucket name

  else
    config.storage :file
  end
end







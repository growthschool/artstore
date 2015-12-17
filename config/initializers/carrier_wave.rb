CarrierWave.configure do |config|
  if Rails.env.production?
    config.storage :fog
    config.fog_credentials = {
      provider:              'AWS',
      aws_access_key_id:     'xxx',      # 你的 key

      aws_secret_access_key: 'yyy',      # 你的 secret key

      region:                'eu-west-1' # 你的 S3 bucket 的 Region 位置

    }
    config.fog_directory  = 'xxxx' # 你設定的 bucket name

  else
    config.storage :file
  end
end

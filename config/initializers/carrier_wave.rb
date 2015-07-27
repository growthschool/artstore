CarrierWave.configure do |config|
  if Rails.env.production?
    # config.fog_provider = 'fog'
    config.fog_credentials = {
      provider:              'AWS',
      aws_access_key_id:     ENV['S3_ACCESS_KEY'], # 你的 key
      aws_secret_access_key: ENV['S3_SECRET_KEY'], # 你的 secret key
      region:                ENV['S3_REGION'] # 你的 S3 bucket 的 Region 位置
    }
    config.fog_directory  = ENV['S3_BUCKET_NAME'] # 你設定的 bucket name

    # don't use ssl connection to aws s3
    config.fog_use_ssl_for_aws false

    # use fog to storage
    config.storage :fog
  else
    config.storage :file
  end
end

CarrierWave.configure do |config|
  if Rails.env.production?
    config.storage :fog
    config.fog_credentials = {
      provider:              'AWS',
      aws_access_key_id:     ENV['pay2go_merchant_id'],      # 你的 key

      aws_secret_access_key: ENV['pay2go_merchant_id'],      # 你的 secret key

      region:                'Tokyo' # 你的 S3 bucket 的 Region 位置

    }
    config.fog_directory  = ENV['pay2go_merchant_id'] # 你設定的 bucket name

  else
    config.storage :file
  end
end

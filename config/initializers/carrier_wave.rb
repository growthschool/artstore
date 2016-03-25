CarrierWave.configure do |config|
  if Rails.env.production?
    config.storage :fog
    config.fog_credentials = {
      provider:              'AWS',
      aws_access_key_id:     'AKIAI6ERMEEKFGDXNMSQ',      # 你的 key

      aws_secret_access_key: 'SXL6kUoMKJ4AxYVQhMjAST6DaPNHgxi7FxgYBSa8',      # 你的 secret key

      region:                'ap-northeast-1' # 你的 S3 bucket 的 Region 位置
      # region:                'us-west-2' # 你的 S3 bucket 的 Region 位置

    }
    config.fog_directory  = 'danielstore' # 你設定的 bucket name

  else
    config.storage :file
  end
end

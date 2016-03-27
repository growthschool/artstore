CarrierWave.configure do |config|
  if Rails.env.production?
    config.storage :fog
    config.fog_credentials = {
      provider:              'AWS',
      aws_access_key_id:     'AKIAIN6CIVT5MYITASFA',      # 你的 key

      aws_secret_access_key: '9T0DelBPdKwR1MzCSJgVmqf57sM7Z4worA8YUaRc',      # 你的 secret key


      region:                'us-west-1' # 你的 S3 bucket 的 Region 位置

    }
    config.fog_directory  = 'artstorethirdweekmf' # 你設定的 bucket name

  else
    config.storage :file
  end
end

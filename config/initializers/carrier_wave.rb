CarrierWave.configure do |config|
  if Rails.env.production? 
    config.storage :fog                       
    config.fog_credentials = {
      provider:              'AWS',                        
      aws_access_key_id:     'AKIAIPN4WNEPYR5VDCNQ',      # 你的 key           

      aws_secret_access_key: 'SlwkRruxLkPJI46O4alGMUywtaXMKxt+K+YO7bY4',      # 你的 secret key         

      region:                'us-east-1' # 你的 S3 bucket 的 Region 位置   

    }
    config.fog_directory  = 'rails101' # 你設定的 bucket name 

  else
    config.storage :file
  end
end
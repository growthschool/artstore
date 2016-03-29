CarrierWave.configure do |config|
  if Rails.env.production? 
    config.storage :fog                       
    config.fog_credentials = {
      provider:              ENV['provider']
      aws_access_key_id:     ENV['s3_key_id'],      # 你的 key           
      aws_secret_access_key: ENV['s3_key_secret'],      # 你的 secret key         
      region:                ENV['region'] # 你的 S3 bucket 的 Region 位置   
    }
    config.fog_directory  = 'artstore-photo' # 你設定的 bucket name 
  else
    config.storage :file
  end
end


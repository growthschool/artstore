CarrierWave.configure do |config|
  if Rails.env.production? 
    config.storage :fog                       
    config.fog_credentials = {
      provider:              'AWS',                        
      aws_access_key_id:     'AKIAICZ7FFIG6QKIPDFA',      # 你的 key           

      aws_secret_access_key: 'U77rO0lEeYdMVGW5j0ZV1dnAbEs4R8SUvPsdNwGd',      # 你的 secret key         

      region:                'Oregon' # 你的 S3 bucket 的 Region 位置   

    }
    config.fog_directory  = 's3wahaha3s' # 你設定的 bucket name 

  else
    config.storage :file
  end
end
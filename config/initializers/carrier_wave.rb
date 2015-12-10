CarrierWave.configure do |config|
  if Rails.env.production? 
    config.storage :fog                       
    config.fog_credentials = {
      provider:              'AWS',                        
      aws_access_key_id:     'AKIAJJZZDQ2FWGYZN7CQ',
      aws_secret_access_key: '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',
      region:                'us-west-1' 
    }
    config.fog_directory  = 'artstorekh'  
  else
    config.storage :file
  end
end
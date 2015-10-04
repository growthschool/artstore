CarrierWave.configure do |config|
	if Rails.env.production?
		config.fog_credentials = {
			provider: "AWS",
			aws_access_key_id: ENV["AWS_ACCESS_KEY_ID"],
			aws_secret_access_key: ENV["AWS_SECRET_ACCESS_KEY"],
			region: ENV["AWS_REGION"] 
		}
		# directory 設定成 S3 上的 bucket 名稱即可 
		config.fog_directory = ENV["AWS_BUCKET"]
		config.storage :fog
	else
		config.storage :file
	end
end

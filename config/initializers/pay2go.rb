Pay2go.setup do |pay2go|
	if Rails.env.development?
		pay2go.merchant_id = "31133783"
		pay2go.hash_key = "i4iTq0q78i5otopNWOZb52C01AhoDaFV"
		pay2go.hash_iv = "eYPEYgM7zRw3fVQc"
		pay2go.service_url = "https://capi.pay2go.com/MPG/mpg_gateway"
	else
		pay2go.merchant_id = "31133783"
		pay2go.hash_key = "i4iTq0q78i5otopNWOZb52C01AhoDaFV"
		pay2go.hash_iv = "eYPEYgM7zRw3fVQc"
		pay2go.service_url = "https://api.pay2go.com/MPG/mpg_gateway"

	end
end


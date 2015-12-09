Pay2go.setup do |pay2go|
  if Rails.env.development?
    pay2go.merchant_id = ENV['11191272']
    pay2go.hash_key    = ENV['CRvjjdVZjOEKGbeeR547mDL7vsE12iaE']
    pay2go.hash_iv     = ENV['aFYtTTtcI8WojbDa']
    pay2go.service_url = ENV['https://capi.pay2go.com/MPG/mpg_gateway']
  else
    pay2go.merchant_id = ENV['11191272']
    pay2go.hash_key    = ENV['CRvjjdVZjOEKGbeeR547mDL7vsE12iaE']
    pay2go.hash_iv     = ENV['aFYtTTtcI8WojbDa']
    pay2go.service_url = ENV['https://api.pay2go.com/MPG/mpg_gateway']
  end
end
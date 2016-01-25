Pay2go.setup do |pay2go|
  if Rails.env.development?
    #pay2go.merchant_id = "11420230"  # 放測試站的 key
    #pay2go.hash_key    = "vQp3KYnk7LZVNbT4O0LS22cFbBvr4cVz"
    #pay2go.hash_iv     = "3lCNj07rL7nyihC7"
    #pay2go.service_url = "https://capi.pay2go.com/MPG/mpg_gateway"
    pay2go.merchant_id = ENV['pay2go_merchant_id']
    pay2go.hash_key    = ENV['pay2go_hash_key']
    pay2go.hash_iv     = ENV['pay2go_hash_iv']
    pay2go.service_url = ENV['pay2go_service_url']
  else
    #pay2go.merchant_id = "11420230"  # 放正式站的 key
    #pay2go.hash_key    = "vQp3KYnk7LZVNbT4O0LS22cFbBvr4cVz"
    #pay2go.hash_iv     = "3lCNj07rL7nyihC7"
    #pay2go.service_url = "https://api.pay2go.com/MPG/mpg_gateway"
    pay2go.merchant_id = ENV['pay2go_merchant_id']
    pay2go.hash_key    = ENV['pay2go_hash_key']
    pay2go.hash_iv     = ENV['pay2go_hash_iv']
    pay2go.service_url = ENV['pay2go_service_url']
  end
end
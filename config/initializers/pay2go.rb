Pay2go.setup do |pay2go|
  if Rails.env.development?
    pay2go.merchant_id = "11420230"  # 放測試站的 key

    pay2go.hash_key    = "vQp3KYnk7LZVNbT4O0LS22cFbBvr4cVz"
    pay2go.hash_iv     = "3lCNj07rL7nyihC7"
    pay2go.service_url = "https://capi.pay2go.com/MPG/mpg_gateway"
  else
    pay2go.merchant_id = "11420230"  # 放正式站的 key

    pay2go.hash_key    = "vQp3KYnk7LZVNbT4O0LS22cFbBvr4cVz"
    pay2go.hash_iv     = "3lCNj07rL7nyihC7"
    pay2go.service_url = "https://api.pay2go.com/MPG/mpg_gateway"
  end
end
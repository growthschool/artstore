Pay2go.setup do |pay2go|
  if Rails.env.development?
    pay2go.merchant_id = "11426224"  # 放測試站的 key

    pay2go.hash_key    = "4Vggxdz0KKBLFnaF4gZXj1YlmmRbfVNk"
    pay2go.hash_iv     = "R4Aoiao2U0OAnZfs"
    pay2go.service_url = "https://capi.pay2go.com/MPG/mpg_gateway"
  else
    pay2go.merchant_id = "1234567"  # 放正式站的 key

    pay2go.hash_key    = "xxxxxxxx"
    pay2go.hash_iv     = "xxxxxxxx"
    pay2go.service_url = "https://api.pay2go.com/MPG/mpg_gateway"
  end
end
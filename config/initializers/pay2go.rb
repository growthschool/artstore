# Pay2go.setup do |pay2go|
#   if Rails.env.development?
#     pay2go.merchant_id = "11110133"  # 放測試站的 key
#     pay2go.hash_key    = "aiXmIwhaJgLlU9mZDAdBuAJpXoU392Ak"
#     pay2go.hash_iv     = "lyG34YeNfZ999w9M"
#     pay2go.service_url = "https://capi.pay2go.com/MPG/mpg_gateway"
#   else
#     pay2go.merchant_id = "11110133"  # 放正式站的 key

#     pay2go.hash_key    = "aiXmIwhaJgLlU9mZDAdBuAJpXoU392Ak"
#     pay2go.hash_iv     = "lyG34YeNfZ999w9M"
#     pay2go.service_url = "https://api.pay2go.com/MPG/mpg_gateway"
#   end
# end

Pay2go.setup do |pay2go|
  if Rails.env.development?
    pay2go.merchant_id = "1974096"
    pay2go.hash_key    = "siQtMNJ3fiDeAdkTOoxrGGIEGrKBXnaq"
    pay2go.hash_iv     = "G0UtOEw3WaiwnCqc"
    pay2go.service_url = "https://capi.pay2go.com/MPG/mpg_gateway"
  else
    pay2go.merchant_id = "1974096"
    pay2go.hash_key    = "siQtMNJ3fiDeAdkTOoxrGGIEGrKBXnaq"
    pay2go.hash_iv     = "G0UtOEw3WaiwnCqc"
    pay2go.service_url = "https://capi.pay2go.com/MPG/mpg_gateway"
  end
end
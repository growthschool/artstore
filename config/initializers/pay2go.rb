# Pay2go.setup do |pay2go|
#   if Rails.env.development?
#     pay2go.merchant_id = "11111536"  # 放測試站的 key
#     pay2go.hash_key    = "xVsFOAAlnT4XiyWUF2wtgyNRY0e85sYGo"
#     pay2go.hash_iv     = "qmc0XyoQCm8bj3Ql"
#     pay2go.service_url = "https://capi.pay2go.com/MPG/mpg_gateway"
#   else
#     pay2go.merchant_id = "1234567"  # 放正式站的 key

#     pay2go.hash_key    = "xxxxxxxx"
#     pay2go.hash_iv     = "xxxxxxxx"
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

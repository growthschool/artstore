Pay2go.setup do |pay2go|
  if Rails.env.development?
    pay2go.merchant_id = ENV['pay2go_merchant_id']
    pay2go.hash_key    = ENV['pay2go_hash_key']
    pay2go.hash_iv     = ENV['pay2go_hash_iv']
    pay2go.service_url = ENV['pay2go_service_url']
  else
    pay2go.merchant_id = ENV['pay2go_merchant_id']
    pay2go.hash_key    = ENV['pay2go_hash_key']
    pay2go.hash_iv     = ENV['pay2go_hash_iv']
    pay2go.service_url = ENV['pay2go_service_url']
  end
end

# Pay2go.setup do |pay2go|
#   if Rails.env.development?
#     pay2go.merchant_id = "11111536"  # 放測試站的 key
#     pay2go.hash_key    = "VsFOAAlnT4XiyWUF2wtgyNRY0e85sYGo"
#     pay2go.hash_iv     = "qmc0XyoQCm8bj3Ql"
#     pay2go.service_url = "https://capi.pay2go.com/MPG/mpg_gateway"
#   else
#     pay2go.merchant_id = "11111536"  # 放正式站的 key
#     pay2go.hash_key    = "VsFOAAlnT4XiyWUF2wtgyNRY0e85sYGo"
#     pay2go.hash_iv     = "qmc0XyoQCm8bj3Ql"
#     pay2go.service_url = "https://api.pay2go.com/MPG/mpg_gateway"
#   end
# end

# Pay2go.setup do |pay2go|
#   if Rails.env.development?
#     pay2go.merchant_id = "1974096"
#     pay2go.hash_key    = "siQtMNJ3fiDeAdkTOoxrGGIEGrKBXnaq"
#     pay2go.hash_iv     = "G0UtOEw3WaiwnCqc"
#     pay2go.service_url = "https://capi.pay2go.com/MPG/mpg_gateway"
#   else
#     pay2go.merchant_id = "1974096"
#     pay2go.hash_key    = "siQtMNJ3fiDeAdkTOoxrGGIEGrKBXnaq"
#     pay2go.hash_iv     = "G0UtOEw3WaiwnCqc"
#     pay2go.service_url = "https://capi.pay2go.com/MPG/mpg_gateway"
#   end
# end

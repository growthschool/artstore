Pay2go.setup do |pay2go|
  if Rails.env.development?
    pay2go.merchant_id = ENV['pay2go_merchant_id']
    pay2go.hash_key    = ENV['pay2go_hash_key']
    pay2go.hash_iv     = ENV['pay2go_hash_iv']

    pay2go.service_url = "https://capi.pay2go.com/MPG/mpg_gateway"
  else
    #pay2go.merchant_id = "11099989"  # 放正式站的 key
    #pay2go.hash_key    = "ZEobJ33C9ExBptxhEXufl7pmjmfI5MY4"
    #pay2go.hash_iv     = "qngaqjMzXkbnOIEt"

    pay2go.merchant_id = ENV['pay2go_merchant_id']
    pay2go.hash_key    = ENV['pay2go_hash_key']
    pay2go.hash_iv     = ENV['pay2go_hash_iv']

    pay2go.service_url = "https://capi.pay2go.com/MPG/mpg_gateway"
    #pay2go.service_url = "https://api.pay2go.com/MPG/mpg_gateway"
  end
end

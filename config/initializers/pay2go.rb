Pay2go.setup do |pay2go|
  if Rails.env.development?
    pay2go.merchant_id = "11098372"
    pay2go.hash_key    = "M0KoE54RVlMB28RSD0rkq2r3ce9bPO4B"
    pay2go.hash_iv     = "PP0uV4lRq8tsgklT"
    pay2go.service_url = "https://capi.pay2go.com/MPG/mpg_gateway"
  else
    pay2go.merchant_id = "11098372  "
    pay2go.hash_key    = "M0KoE54RVlMB28RSD0rkq2r3ce9bPO4B"
    pay2go.hash_iv     = "PP0uV4lRq8tsgklT"
    pay2go.service_url = "https://api.pay2go.com.MPG/mpg_gateway"
  end

end

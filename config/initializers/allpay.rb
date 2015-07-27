ActiveMerchant::Billing::Integrations::Allpay.setup do |allpay|
  if Rails.env.production?
    allpay.merchant_id = "2000132"  # 取得正式 key 以後再換
    allpay.hash_key    = "5294y06JbISpM5x9"
    allpay.hash_iv     = "v77hoKGq4kWxNNIS"
  else
    allpay.merchant_id = "2000132"
    allpay.hash_key    = "5294y06JbISpM5x9"
    allpay.hash_iv     = "v77hoKGq4kWxNNIS"
  end
end

ActionView::Base.send(:include, ActiveMerchant::Billing::Integrations::ActionViewHelper)

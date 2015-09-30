ActiveMerchant::Billing::Integrations::Allpay.setup do |allpay|
  if Rails.env.development?
    # default setting for stage test
    allpay.merchant_id = '2000132'
    allpay.hash_key    = '5294y06JbISpM5x9'
    allpay.hash_iv     = 'v77hoKGq4kWxNNIS'
  else
    # change to yours
    allpay.merchant_id = '7788520'
    allpay.hash_key    = 'adfas123412343j'
    allpay.hash_iv     = '123ddewqerasdfas'
  end
end

ActionView::Base.send(:include, ActiveMerchant::Billing::Integrations::ActionViewHelper)

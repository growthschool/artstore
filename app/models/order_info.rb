class OrderInfo < ActiveRecord::Base
	belongs_to :order

	validated :billing_name, presence: true
	validated :billing_address, presence: true
	validated :shipping_name, presence: true
	validated :shipping_address, presence: true
end

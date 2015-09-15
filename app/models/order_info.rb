class OrderInfo < ActiveRecord::Base
	belongs_to :order

	validates :billing_name, presence: { message: '不得為空' }
	validates :billing_address, presence: { message: '不得為空' }
	validates :shipping_name, presence: { message: '不得為空' }
	validates :shipping_address, presence: { message: '不得為空' }

end

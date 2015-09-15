class Order < ActiveRecord::Base
	belongs_to :user

	has_many :items, class_name: "OrderItem", dependent: :destroy
	has_one :info, class_name: "OrderInfo", dependent: :destroy

	# 有這行才可以用巢狀表單
	accepts_nested_attributes_for :info

	# 暫存交易紀錄
	def build_item_cache_from_cart(cart)
		cart.items.each do |cart_item|
			item = items.build
			item.product_name = cart_item.title
			item.quantity = 1
			item.price = cart_item.price
			item.save
		end
	end

	# 把總額存在 total 欄位上
	def calculate_total!(cart)
		self.total = cart.total_price
		self.save
	end
end

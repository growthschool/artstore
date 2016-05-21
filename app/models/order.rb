class Order < ActiveRecord::Base
	belongs_to :user
	has_many :items, class_name: "OrderItem",dependent: :destroy
	has_one  :info , class_name: "OrderInfo",dependent: :destroy

	accepts_nested_attributes_for :info

	def build_item_snap_from_cart(cart)
		cart.items.each do |cart_item|
			item = items.new
			item.product_name = cart_item.title
			item.quantity = 1
      		item.price = cart_item.price
      		item.save
		end
	end

	def caculate_total!(cart)
		self.total = cart.price_total
		self.save
	end

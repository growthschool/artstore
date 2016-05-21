class Cart < ActiveRecord::Base
	has_many :cart_items, dependent: :destroy
	has_many :items, through: :cart_items, source: :product

	def add_product_to_cart(product)
		ci = cart_items.new
		ci.product = product
		ci.save
	end

	def price_total
		sum = 0
		items.each do |item|
			sum = sum + item.price
		end
		sum
	end
end

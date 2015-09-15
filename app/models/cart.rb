class Cart < ActiveRecord::Base
	has_many :cart_items
	has_many :items, through: :cart_items, source: :product

	def add_product_to_cart(product)
		items << product
	end

	def total_price
		#items.inject(0) { |sum, item| sum + item.price }

		sum = 0

		items.each do |item|
			sum += item.price
		end

		return sum
	end
end

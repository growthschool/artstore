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
		cart_items.each do |cart_item|
			sum = sum + (cart_item.product.price * cart_item.quantity)
		end
		sum
	end

	def clear!
		cart_items.destroy_all
	end
end

class CartItem < ActiveRecord::Base
	belongs_to :cart
	belongs_to :product

	def total
		self.product.price * self.quantity
	end
end

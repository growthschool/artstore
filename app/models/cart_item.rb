class CartItem < ActiveRecord::Base
	belongs_to :cart
	belongs_to :product

	after_save    :reduce_quantity
	after_destroy :return_quantity
	
	def reduce_quantity
		product.quantity = product.max_quantity - self.quantity
		product.save
	end

	def return_quantity
		product.quantity += self.quantity
		product.save
	end

	def reduce_max_quantity_when_ordered(num)
		product.max_quantity -= num
		product.save
	end
end

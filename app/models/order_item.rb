class OrderItem < ActiveRecord::Base
	belongs_to :order

	def total
		self.price * self.quantity
	end
end

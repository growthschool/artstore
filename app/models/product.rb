class Product < ActiveRecord::Base
	has_many :photos
	accepts_nested_attributes_for :photos

	def default_photo
		photos.last
	end

	def has_inventory?
		self.quantity > 0
	end
end

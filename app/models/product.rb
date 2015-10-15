class Product < ActiveRecord::Base
	has_many :photos
	accept_nested_attributes_for :photos

def default_photo
	photos.first
	
end

end

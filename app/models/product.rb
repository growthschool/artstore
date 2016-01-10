class Product < ActiveRecord::Base
	has_one :photo, dependent: :destroy
	accepts_nested_attributes_for :photo
end

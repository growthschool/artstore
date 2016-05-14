class Product < ActiveRecord::Base
	validates :title, presence: true
	validates :quantity, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
	validates :price, numericality: { greater_than: 0 }
	has_one :photo
	accepts_nested_attributes_for :photo
end

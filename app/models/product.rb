class Product < ActiveRecord::Base
  has_one :photo, dependent: :destroy
  has_many :cart_items, dependent: :destroy
  
  accepts_nested_attributes_for :photo
end

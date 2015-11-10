class Product < ActiveRecord::Base
  has_one :photo
  accept_nested_attributes_for :photo
end

class Product < ActiveRecord::Base

  has_one :photo
  accepts_nested_attributes_for :photo
end

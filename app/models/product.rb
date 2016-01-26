class Product < ActiveRecord::Base
  has_one :photo

  accepts_nested_attribute_for :photo
end

class Product < ActiveRecord::Base
  has_one :photo
  accepts_nested_atrribute_for :photo
end

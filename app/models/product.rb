class Product < ActiveRecord::Base
  #這裡兩個分別為什麼意思
  has_one :photo

  accepts_nested_attributes_for :photo
end

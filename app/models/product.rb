class Product < ActiveRecord::Base
  has_one :photo

  accepts_nested_attributes_for :photo  #預設nested_attributes是關閉的  要打這行開啟photo的nested_attributes
end

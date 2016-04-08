class Product < ActiveRecord::Base
  has_one :photo

  accepts_nested_attributes_for :photo #怎麼知道要下這個指令？
end

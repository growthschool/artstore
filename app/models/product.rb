class Product < ActiveRecord::Base
  has_one :photo

  accepts_nested_attributes_for :photo
  # 請問這是什麼意思？
end

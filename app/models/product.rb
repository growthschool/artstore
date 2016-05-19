class Product < ActiveRecord::Base

  has_one :photo
  accepts_nested_attributes_for :photo

  validates :title, :description, :quantity, :price, presence: true

end

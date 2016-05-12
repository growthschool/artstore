class Product < ActiveRecord::Base

  validates :title, :description, :quantity, :price, presence: true

end

class CartItem < ActiveRecord::Base
  belongs_to :Cart
  belongs_to :product
end

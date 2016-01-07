class CartItem < ActiveRecord::Base
  belongs_to :cart, counter_cache: true
  belongs_to :product
end

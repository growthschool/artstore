class CartItem < ActiveRecord::Base
  belongs_to :cart
  belongs_to :product
  def sum
    self.product.price * self.quantity
  end
end

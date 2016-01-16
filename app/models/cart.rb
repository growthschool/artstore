class Cart < ActiveRecord::Base
  has_many :cart_items, dependent: :destroy
  has_many :items, through: :cart_items, source: :product


  def add_product_to_cart(product)
    ci = cart.cart_items.build
    ci.product = product
    ci.save
    # items << product
  end
end

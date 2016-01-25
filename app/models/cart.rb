class Cart < ActiveRecord::Base
  has_many :cart_items, dependent: :destroy
  has_many :items, through: :cart_items, source: :product

  def find_cart_item(product)
    cart_items.find_by(product_id: product)
  end

  def add_product_to_cart(product)
    items << product
  end
  def total_price
    cart_items.inject(0) { |sum, cart_item| sum + (cart_item.product.price * cart_item.quantity) }
  end
  def clean!
    cart_items.destroy_all
  end
end

class Cart < ActiveRecord::Base
  has_many :cart_items, dependent: :destroy
  has_many :items, through: :cart_items, source: :product

  def add_product_to_cart(product)
    cart_item = cart_items.find_by(product_id: product)
    cart_item.nil? ? items << product : cart_item.increment!(:quantity)
  end

  def total_price
    cart_items.inject(0) do |sum, cart_item|
      sum + (cart_item.product.price * cart_item.quantity)
    end
  end

  def find_cart_item(product)
    cart_items.find_by(product_id: product)
  end
end

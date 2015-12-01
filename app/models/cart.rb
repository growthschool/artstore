class Cart < ActiveRecord::Base
  has_many :cart_items, dependent: :destroy
  has_many :items, through: :cart_items, source: :product

  def add_product_to_cart(product)
    items << product
  end

  def total_price
    items.inject(0) { |sum, item| sum + item.price }
  end

  def clean!
    cart_items.destroy_all
  end
end

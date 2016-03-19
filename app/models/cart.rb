class Cart < ActiveRecord::Base
  has_many :cart_items, dependent: :destroy
  has_many :items, through: :cart_items, source: :product

  def add_product_to_cart(product)
    items << product
  end

  def total_price
    sum = 0

    items.each do |product|
      sum = sum + product.price
    end

    return sum
  end
end

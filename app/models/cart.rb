class Cart < ActiveRecord::Base
  has_many :cart_items, dependent: :destroy
  has_many :items, through: :cart_items, source: :product

  def add_product_to_cart(product)
    items << product
  end

  def total_price
    items.inject(0) { |sum, product| sum + product.price }

    # sum = 0
    # items.each do |product|
    #   sum += product.price
    # end
    # sum
  end
end

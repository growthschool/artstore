class Cart < ActiveRecord::Base

  has_many :cart_items, dependent: :destroy
  has_many :items, through: :cart_items, source: :product

  def add_product_to_cart(product)

      items << product
  end

  def total_price

    #items.inject(0) { |sum, item| sum + item.price}
    cart_items.inject(0) { |sum, item| sum + (item.product.price * item.quantity) }

    #sum = 0
    #items.each do |item|
    #  sum = sum + item.price
    #end

    # return sum

  end

  def find_cart_item(product)

    cart_items.find_by(product_id: product)
  end

  def clean!

    cart_items.destroy_all

  end
end

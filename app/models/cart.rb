class Cart < ActiveRecord::Base
  has_many :cart_items, dependent: :destroy
  has_many :items, through: :cart_items, source: :product

  def add_product_to_cart(product)
    items << product
  end

  def total_price
    cart_items.inject(0) { |sum, cart_item| sum + (cart_item.quantity * cart_item.product.price)}

    #items.inject(0) { |sum, product| sum + product.price }

    # sum = 0
    # items.each do |product|
    #   sum += product.price
    # end
    # sum
  end

  def clean!
    items.destroy_all
  end

  def empty?
    items.empty?
  end

  def find_cart_item_by_product(product)
    cart_items.find_by(product_id: product)
  end
end

class Cart < ActiveRecord::Base
  has_many :cart_items, dependent: :destroy
  has_many :items, through: :cart_items, source: :product

  def find_cart_items(product)
    cart_items.find_by(product_id: product)
  end

  def add_product_to_cart(product, amount)
    #items << product
    cart_item = cart_items.build
    cart_item.product = product
    cart_item.quantity = amount
    cart_item.save
  end

  def total_price
    #items.inject(0) { |sum, item| sum+ item.price}
    cart_items.inject(0) { |sum,item| sum+ (item.product.price * item.quantity)}
  end

  def clean!
    cart_items.destroy_all
  end

end

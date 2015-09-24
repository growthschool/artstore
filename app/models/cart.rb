class Cart < ActiveRecord::Base

  has_many :cart_items, :dependent => :destroy
  has_many :items, :through => :cart_items, :source => :product

  def find_cart_item(product)
    cart_items.find_by(product_id: product)
  end

  def add_product_to_cart(product, amount)
    cart_item = cart_items.build
    cart_item.product = product
    cart_item.quantity = amount
    cart_item.save
  end

  def total_price

 #items.inject(0) { |sum, item| sum + (item.price * item.quantity) }
    sum = 0

       cart_items.each do |item|
      sum = sum + (item.product.price * item.quantity)
    end

    return sum

  end

  def clean!
    cart_items.destroy_all
  end

end

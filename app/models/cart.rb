class Cart < ActiveRecord::Base
  has_many :cart_items, dependent: :destroy
  has_many :items, through: :cart_items, source: :product
  def find_cart_item(product)
    cart_items.find_by(product_id: product)
  end
  def add_product_to_cart(product)
    items << product
  end
  def clean!
    cart_items.destroy_all
  end
  def hasItem?
    return (cart_items.count > 0)
  end
  def total_price
    # items.inject(0){ |sum, item| sum + item.price }
    sum=0
    cart_items.each do |item|
      # sum = sum + item.product.price * item.quantity
      sum = sum + item.sum
    end
    sum
  end
end

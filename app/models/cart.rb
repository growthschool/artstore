class Cart < ActiveRecord::Base
  has_many :cart_items, dependent: :destroy
  has_many :items, through: :cart_items, source: :product
  def add_product_to_cart(product)
    items << product
  end
  def clean!
    cart_items.clear
    items.clear
  end
  def hasItem?
    return (cart_items.count > 0)
  end
  def total_price
    # items.inject(0){ |sum, item| sum + item.price }
    sum=0
    items.each do |item|
      sum=sum+item.price
    end
    sum
  end
end

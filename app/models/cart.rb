class Cart < ActiveRecord::Base
  has_many :cart_items, dependent: :destroy
  has_many :items, through: :cart_items, source: :product

  def add_product_to_cart(product)
    items << product
  end


  # Ruby語法 .inject() 的黑魔法
  def total_price
    items.inject(0) { |sum, item| sum + item.price }
  end

    # sum = 0

    # items.each do |item|
    # sum = sum + item.price
    # end

    # return sum
end

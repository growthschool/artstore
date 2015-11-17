class Cart < ActiveRecord::Base
  has_many :cart_items, dependent: :destroy
  has_many :items, through: :cart_items, source: :product

  def add_product_to_cart(product)
    items << product
  end


  # Ruby語法 .inject() 的黑魔法
  def total_price
    cart_items.inject(0) { |sum, item| sum + (item.product.price  * item.quantity) }
  end

    # sum = 0

    # items.each do |item|
    # sum = sum + item.price
    # end

    # return sum

  def clean!
    cart_items.destroy_all    # 對購物車內的項目進行detroy_all
  end

end

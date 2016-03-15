class Cart < ActiveRecord::Base
  has_many :cart_items, dependent: :destroy
  has_many :goods, through: :cart_items, source: :product

  def add_product_to_cart(product)
    ci = cart_items.build
    ci.product = product
    ci.save
  end

  def total_price
    sum = 0

    goods.each do |good|
      sum = sum + good.price
    end
    sum
  end
end

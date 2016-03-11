class Cart < ActiveRecord::Base
  has_many :cart_items, dependent: :destroy
  has_many :items, through: :cart_items, source: :product

  def add_product_to_cart(product)
    ci = cart_items.build #current.cart_items.build在cart_items新增一筆cart_id = current_cart的資料
    ci.product = product #把cart_items的product_id設成想要加入購物車的product的id
    ci.save
  end

  def total_price
    sum = 0

    cart_items.each do |item|
      sum = sum + (item.product.price*item.quantity)
    end
    sum
  end

  def clean!
    cart_items.destroy_all
  end
  def find_cart_item(product)
    cart_items.find_by(product_id: product)
  end
end

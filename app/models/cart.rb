class Cart < ActiveRecord::Base
  has_many :cart_items, dependent: :destroy
  has_many :items, through: :cart_items, source: :product  #直接寫products? 是因為寫加入購物車名稱會混淆？

  def find_cart_item(product)
    cart_items.find_by(product_id: product)
  end

  def add_product_to_cart(product)
    items << product
  end

  def total_price
    cart_items.inject(0) { |sum, item| sum + (item.product.price * item.quantity) } #product.price???
  end

end

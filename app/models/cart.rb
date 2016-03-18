class Cart < ActiveRecord::Base
  has_many :cart_items, dependent: :destroy
  has_many :items, through: :cart_items, source: :product

  def add_product_to_cart(product, quantity)
    ci = cart_items.build
    ci.product = product
    ci.quantity = quantity
    ci.save
  end

  def total_price
    sum = 0

    cart_items.each do |cart_item|
      sum += cart_item.quantity * cart_item.product.price
    end

    sum
  end

  def empty!
    cart_items.destroy_all
  end
end

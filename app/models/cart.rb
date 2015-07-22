class Cart < ActiveRecord::Base
  has_many :cart_items, dependent: :destroy
  has_many :items, through: :cart_items, source: :product
  #Cart與Product是多對多關係，透過中介資料表(CartItem)，達到多對多關係
  #Cart.find(1).items.all 某台購物車裡所有產品


  def add_product_to_cart(product,amount)
    cart_item = cart_items.build
    cart_item.product = product
    cart_item.quantity = amount
    cart_item.save
  end

  def total_price
    #byebug 中斷點
    cart_items.inject(0) {|sum, item| sum + (item.product.price * item.quantity) }
 
    # sum = 0
 
    # items.each do |item|
    #   sum = sum + item.price
    # end
 
    # return sum 
  end

  def clean!
    cart_items.destroy_all
  end
 
end

# == Schema Information
#
# Table name: carts
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

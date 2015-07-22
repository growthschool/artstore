class Cart < ActiveRecord::Base
  has_many :cart_items, dependent: :destroy
  has_many :items, through: :cart_items, source: :product
  #Cart與Product是多對多關係，透過中介資料表(CartItem)，達到多對多關係
  #Cart.find(1).items.all 某台購物車裡所有產品


  def add_product_to_cart(product)
    items << product
  end

  def total_price
    #byebug 中斷點
    items.inject(0) { |sum, item| sum + item.price}
 
 
    # sum = 0
 
    # items.each do |item|
    #   sum = sum + item.price
    # end
 
    # return sum 
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

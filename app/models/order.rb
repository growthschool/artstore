class Order < ActiveRecord::Base
  belongs_to :user
  has_one :info , class_name:"OrderInfo" , dependent: :destroy
  has_many :items , class_name:"OrderItem" , dependent: :destroy

  def build_item_cache_from_cart(cart)
    cart.items.each do |cart_item|
      item = items.build
      item.product_name = cart_item.title
      item.quantity = cart.find_cart_item(cart_item).quantity
      item.price = cart_item.price
      item.save
    end
  end

  def calculate_total!(cart)
    self.total = cart.total_peice
    self.save
  end
end

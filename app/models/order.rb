class Order < ActiveRecord::Base
  belongs_to :user
  has_many :purchases, class_name: "OrderItem", dependent: :destroy
  has_one :info, class_name: "OrderInfo", dependent: :destroy

  accepts_nested_attributes_for :info

  def build_item_catch(cart)
    cart.goods.each do |cart_item|
      item = purchases.build
      item.product_name = cart_item.title
      item.quantity = 1
      item.price = cart_item.price
      item.save
    end
  end

  def calculate_total(cart)
    self.total = cart.total_price
    self.save
  end
end

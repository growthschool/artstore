class Order < ActiveRecord::Base
  belongs_to :user

  has_many :items, class_name: "OrderItem", dependent: :destroy
  has_one :info, class_name: "OrderInfo", dependent: :destroy

  accepts_nested_attributes_for :info

  def build_item_cache_from_cart(cart)
    cart.items.each do |product|
      item = items.build
      item.product_name = product.title
      item.quantity = 1
      item.price = product.price
      item.save
    end
  end

  def calculate_total!(cart)
    self.update_columns(total: cart.total_price)
  end
end

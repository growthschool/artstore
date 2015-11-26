class Order < ActiveRecord::Base
  before_create :generate_token

  belongs_to :user

  has_many :items, class_name: "OrderItem", dependent: :destroy
  has_one :info, class_name: "OrderInfo", dependent: :destroy

  accepts_nested_attributes_for :info

  # create order_items record
  def build_item_cache_from_cart(cart)
    cart.items.each do |product|
      item = items.new
      item.product_name = product.title
      item.quantity = 1
      item.price = product.price
      item.save
    end
  end

  # fill orders.total
  def calculate_total(cart)
    self.total = cart.total_price
    self.save
  end

  def generate_token
    self.token = SecureRandom.uuid
  end

  def set_payment_with!(method)
    update_columns(payment_method: method)
  end

  def pay!
    update_columns(is_paid: true)
  end

end

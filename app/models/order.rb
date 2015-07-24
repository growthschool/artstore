class Order < ActiveRecord::Base

  belongs_to :user
  has_many :items, :class_name => "OrderItem", :dependent => :destroy
  has_one :info, :class_name => "OrderInfo", :dependent => :destroy
  before_create :generate_token

  accepts_nested_attributes_for :info
 
  def build_item_cache_from_cart(cart)
    cart.cart_items.each do |cart_item|
      item = items.build
      item.product_name = cart_item.product.title
      item.quantity = cart_item.quantity
      item.price = cart_item.product.price
      item.save
    end
  end

  def calculate_total!(cart)
    self.total = cart.total_price
    self.save
  end
 
  def generate_token
    self.token = SecureRandom.uuid #產生order前先生成亂數token
  end

  def paid?
    is_paid
  end

  def set_payment_with!(method)
    self.update_column(:payment_method, method )
  end

  def pay!
    self.update_column(:is_paid, true )
  end

end

# == Schema Information
#
# Table name: orders
#
#  id             :integer          not null, primary key
#  user_id        :integer
#  total          :integer          default(0)
#  paid           :boolean          default(FALSE)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  token          :string
#  is_paid        :boolean          default(FALSE)
#  payment_method :string
#
# Indexes
#
#  index_orders_on_token  (token)
#

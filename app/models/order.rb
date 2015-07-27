class Order < ActiveRecord::Base
  belongs_to :user
  has_many :items, :class_name => "OrderItem", :dependent => :destroy
  has_one :info, :class_name => "OrderInfo", :dependent => :destroy
 
  accepts_nested_attributes_for :info
 
  before_create :generate_token
 
  def build_item_cache_from_cart(cart)
    cart.items.each do |cart_item|
      item = items.build
      item.product_name = cart_item.title
      item.quantity = cart_item.quantity
      item.price = cart_item.price
      item.save
    end
  end

  def calculate_total!(current_cart)
    self.total = current_cart.total_price
    self.save
    
  end

  def generate_token
    self.token = SecureRandom.uuid
  end

  def paid?
    is_paid
  end

  def set_payment_with!(method)
    self.update_to(:payment_method, method)
  end

  def pay!
    self.update_to_column(:is_paid, true)
  end
end

# == Schema Information
#
# Table name: orders
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  total      :integer
#  paid       :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  token      :string
#  is_paid    :boolean          default("f")
#  paymethod  :string
#
# Indexes
#
#  index_orders_on_token  (token)
#

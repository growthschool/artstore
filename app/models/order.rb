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
#  aasm_state     :string           default("order_placed")
#
# Indexes
#
#  index_orders_on_aasm_state  (aasm_state)
#  index_orders_on_token       (token)
#

class Order < ActiveRecord::Base
  belongs_to :user
  has_many :items, class_name: "OrderItem", dependent: :destroy
  has_one :info, class_name: "OrderInfo", dependent: :destroy

  accepts_nested_attributes_for :info

  scope :recent, -> { order("id DESC")  }

  def build_item_cache_from_cart(cart)
    cart.items.each do |cart_item|
      item = items.build
      item.product_name = cart_item.title
      item.quantity = cart_item.quantity
      item.price = cart_item.price
      item.save
    end
  end

  def calculate_total!(cart)
    self.total = cart.total_price
    self.save
  end

  before_create :generate_token

  def generate_token
    self.token = SecureRandom.uuid
  end

  def is_paid?
    is_paid
  end

  def pay!
    self.update_column(:is_paid, true)
  end

  def set_payment_with!(method)
    self.update_column(:payment_method, method)
  end

  include AASM

  aasm do
   state :order_placed, initial: true
   state :paid
   state :shipping
   state :shipped
   state :order_cancelled
   state :good_returned


   event :make_payment, after_commit: :pay! do
     transitions from: :order_placed, to: :paid
   end

   event :ship do
     transitions from: :paid,         to: :shipping
   end

   event :deliver do
     transitions from: :shipping,     to: :shipped
   end

   event :return_good do
     transitions from: :shipped,      to: :good_returned
   end

   event :cancel_order do
     transitions from: [:order_placed, :paid], to: :order_cancelled
   end
  end

end

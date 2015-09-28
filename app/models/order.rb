class Order < ActiveRecord::Base
  include  AASM

  aasm do
    state :order_placed, initial: true
    state :paid, after_commit: :pay!
    event :make_payment do
      transitions from: :order_placed, to: :paid
    end

    state :shipping
    event :ship do
      transitions from: :paid, to: :shipping
    end

    state :shipped
    event :deliver do
      transitions from: :shipping, to: :shipped
    end

    state :order_cancelled
    event :cancell_order do
      transitions from: [:order_placed, :paid], to: :order_cancelled
    end

    state :good_returned
    event :return_good do
      transitions from: [:shipped], to: :good_returned
    end
  end


  belongs_to :user
  before_create :generate_token

  has_many :items, class_name: "OrderItem", dependent: :destroy
  has_one :info, class_name: "OrderInfo", dependent: :destroy

  accepts_nested_attributes_for :info

  scope :recent, -> { order("id DESC")}

  def build_item_cache_from_cart(cart)
    cart.items.each do | cart_item |
      item = items.build
      item.product_name = cart_item.title
      item.quantity = cart.find_cart_item(cart_item).quantity
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

  def set_payment_with!(method)
    self.update_column(:payment_method, method)
  end

  def pay!
    self.update_column(:is_paid, true)
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
#  aasm_state     :string
#
# Indexes
#
#  index_orders_on_token  (token)
#

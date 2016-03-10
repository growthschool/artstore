class Order < ActiveRecord::Base
  belongs_to :user
  has_many :items, class_name: "OrderItem", dependent: :destroy
  has_one :info, class_name: "OrderInfo", dependent: :destroy
  accepts_nested_attributes_for :info
  before_create :generate_token
  include AASM

  aasm do
    state :order_placed, initial: true
    state :paid
    state :shipping
    state :shipped
    state :order_canceled
    state :good_return
    #先列出各個階段的狀態
    event :make_payment, after_commit: :pay! do
      transitions from: :order_placed, to: :paid
    end
    event :ship do
      transitions from: :paid, to: :shipping
    end
    event :deliver do
      transitions from: :shipping, to: :shipped
    end
    event :return_good do
      transitions from: :shipped, to: :good_return
    end
    event :cancel_order do
      transitions from: [:order_placed, :paid], to: :order_canceled
    end
    #把每個狀態到每個狀態之間的過程作命名
  end

  def build_item_cache_from_cart(cart)
    cart.items.each do |cart_item|
      item = items.build #
      item.product_name = cart_item.title
      item.quantity = cart_item.quantity
      item.price = cart_item.price
    end
  end

  def calculate_total!(cart)
    self.total = cart.total_price #order的欄位改成購物車的total_price
    self.save
  end

  def generate_token
    self.token = SecureRandom.uuid
  end

  def set_payment_with!(method)
    self.update_columns(payment_method: method)
  end

  def pay!
    self.update_columns(is_paid: true)
  end

end

class Order < ActiveRecord::Base
  include AASM

  belongs_to :user

  has_one :info, class_name: 'OrderInfo', dependent: :destroy
  has_many :items, class_name: 'OrderItem', dependent: :destroy

  accepts_nested_attributes_for :info

  before_create :generate_token

  def build_item_cache_from_cart(cart)
    cart.items.each do |cart_item|
      item = items.build
      item.product_name = cart_item.title
      item.quantity = 1
      item.price = cart_item.price
      item.save
    end
  end

  def caculate_total!(cart)
    self.total = cart.total_price
    save
  end

  def set_payment_with!(method)
    update_attributes(payment_method: method)
  end

  def pay!
    update_attributes(is_paid: true)
  end

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
      transitions from: :paid, to: :shipping
    end

    event :deliver do
      transitions from: :shipping, to: :shipped
    end

    event :return_good do
      transitions from: :shipped, to: :good_returned
    end

    event :cancell_order do
      transitions from: [:order_placed, :paid], to: :order_cancelled
    end
  end

  private

  def generate_token
    self.token = SecureRandom.uuid
  end
end

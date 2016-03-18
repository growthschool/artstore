class Order < ActiveRecord::Base
  belongs_to :user

  has_many :items, class_name: "OrderItem", dependent: :destroy
  has_one :info, class_name: "OrderInfo", dependent: :destroy

  accepts_nested_attributes_for :info

  before_create :generate_token

  def build_item_cache_from_cart(cart)
    cart.cart_items.each do |cart_item|
      item = items.build
      item.product_id = cart_item.product.id
      item.product_name = cart_item.product.title
      item.price = cart_item.product.price
      item.quantity = cart_item.quantity
      item.save
    end
  end

  def calculate_total!(cart)
    self.total = cart.total_price
    self.save
  end

  def total_price
    self.total
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

  def reserve_goods!
    self.items.each do |item|
      @product = Product.find_by_id(item.product_id)
      @product.reduce_goods!(item.quantity)
    end
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
      transitions from: :paid, to: :shipping
    end

    event :deliver do
      transitions from: :shipping, to: :shipped
    end

    event :return_good do
      transitions from: :shipped, to: :good_returned
    end

    event :cancel_order do
      transitions from: [:order_placed, :paid], to: :order_cancelled
    end
  end
end

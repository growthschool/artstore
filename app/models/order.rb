class Order < ActiveRecord::Base
  include AASM

  belongs_to :user

  has_one :info, class_name: 'OrderInfo', dependent: :destroy
  has_many :items, class_name: 'OrderItem', dependent: :destroy

  accepts_nested_attributes_for :info

  before_create :generate_token

  scope :recent, -> { order(created_at: :desc ) }

  def build_item_cache_from_cart(cart)
    Order.transaction do
      cart.items.each do |product_item|
        item = items.build
        item.product_name = product_item.title
        item.quantity = cart.find_cart_item(product_item).quantity
        product_item.decrement!(:quantity, item.quantity)
        item.price = product_item.price
        item.save
      end
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

  def update_state(event)
    possible_events = aasm.events.map { |e| e.name.to_s }
    possible_events.include?(event) ? self.send("#{event}!") : false
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

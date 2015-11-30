class Order < ActiveRecord::Base

  belongs_to :user

  has_many :items, class_name: "OrderItem", dependent: :destroy  # 之後可用order.items呼叫
  # has_many :order_items, dependet: :destroy   雖然這樣寫比較簡單 但之後要呼叫需要打order.order_items 太繞舌不方便閱讀
  has_one  :info,  class_name: "OrderInfo", dependent: :destroy

  accepts_nested_attributes_for :info

  def set_payment_with!(method)
    self.update_columns(payment_method: method )
  end

  def pay!
    self.update_columns(is_paid: true )
  end

  # 將generate_token method 改用mixin的方式 引入Tokenable
  include Tokenable

  def build_item_cache_from_cart(cart)
    cart.items.each do |cart_item|
      item = items.build
      item.product_name = cart_item.title
      item.quantity = cart.find_cart_item(cart_item).quantity # 在cart.rb定義helper find_cart_item(product)以簡化常用程式碼
      item.price = cart_item.price
      item.save
    end
  end

  def calculate_total!(cart)
    self.total = cart.total_price
    self.save
  end

  include AASM

  aasm do
    state :order_placed, initial: true
    state :paid
    state :shipping
    state :shipped
    state :order_cancelled
    state :good_returned


    event :make_payment , after_commit: :pay! do
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

    event :cancell_order do
      transitions from: [:order_placed, :paid], to: :order_cancelled
    end
  end


end

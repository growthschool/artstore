class Order < ActiveRecord::Base

  belongs_to :user
  has_many :items, :class_name => "OrderItem", :dependent => :destroy
  has_one :info, :class_name => "OrderInfo", :dependent => :destroy
  before_create :generate_token
  scope :recent, -> {order("id DESC")} 

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
 
  include Tokenable
  #def generate_token
   # self.token = SecureRandom.uuid #產生order前先生成亂數token
  #end

  def paid?
    is_paid
  end

  def set_payment_with!(method)
    self.update_column(:payment_method, method )
  end

  def pay!
    self.update_column(:is_paid, true )
  end

  include AASM

  aasm do
    state :order_placed, initial: true   #已下單
    state :paid                          #已付款
    state :shipping                      #出貨中
    state :shipped                       #到貨
    state :order_cancelled               #取消訂單
    state :good_returned                 #退貨

    event :make_payment, after_commit: :pay! do  #設定當狀態轉為paid時，自動將訂單『is_paid』設為true
      transitions from: :order_placed, to: :paid  #付款後，訂單(order_placed)狀態會轉為已付款(paid)狀態
    end

    event :ship do  #出貨後，(paid)狀態會轉為出貨中(shipping)狀態
      transitions from: :paid, to: :shipping
    end

    event :deliver do #遞送到貨後，(shipping)狀態會轉為到貨(shipped)狀態
      transitions from: :shipping, to: :shipped
    end

    event :return_good do  #商品退回後，(shipped)狀態會轉為退貨(good_returned)狀態
      transitions from: :shipped, to: :good_returned
    end

    event :cancel_order do  #只有在已下單(order_placed)、已付款(paid)的狀態下，才能退貨。
      transitions from: [:order_placed, :paid], to: :order_cancelled
    end
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
#  aasm_state     :string           default("order_placed")
#
# Indexes
#
#  index_orders_on_aasm_state  (aasm_state)
#  index_orders_on_token       (token)
#

class Order < ActiveRecord::Base
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

  private

  def generate_token
    self.token = SecureRandom.uuid
  end
end

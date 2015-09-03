class Order < ActiveRecord::Base
  belongs_to :user

  has_one :info, class_name: "OrderInfo", dependent: :destroy

  accepts_nested_attributes_for :info

  def calculate_total!(cart)
    self.total = cart.total_price
    self.save
  end
end

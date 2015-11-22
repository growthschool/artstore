class Order < ActiveRecord::Base
  belongs_to :user

  has_many :items, class_name: "OrderItem", dependent :destroy
  has_one  :info,  class_name: "OrderInfo", dependent :destroy

  accepts_nested_attributes_for :info
end

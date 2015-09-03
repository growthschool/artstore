class Order < ActiveRecord::Base
  belongs_to :user

  has_one :info, class_name: "OrderInfo", dependent: :destroy

  accepts_nested_attributes_for :info
end

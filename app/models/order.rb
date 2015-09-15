class Order < ActiveRecord::Base
	belongs_to :user

	has_one :info, class_name: "OrderInfo", dependent: :destroy

	# 有這行才可以用巢狀表單
	accepts_nested_attributes_for :info
end

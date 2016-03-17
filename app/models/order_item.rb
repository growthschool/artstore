class OrderItem < ActiveRecord::Base
  belongs_to :order
  accepts_nested_attributes_fo :info
end

class OrderInfo < ActiveRecord::Base

  belongs_to :order

  validates :billing_name, :billing_address, :shipping_name, :shipping_address, presence: true

end

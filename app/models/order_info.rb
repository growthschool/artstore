class OrderInfo < ActiveRecord::Base
  belongs_to :order

  validates :billing_name,     presence: true
  validates :billing_address,  presence: true
  validates :shipping_name,    presence: true
  validates :shipping_address, presence: true
end

# == Schema Information
#
# Table name: order_infos
#
#  id               :integer          not null, primary key
#  order_id         :integer
#  billing_name     :string
#  billing_address  :string
#  shipping_name    :string
#  shipping_address :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

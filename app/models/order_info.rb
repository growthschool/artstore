class OrderInfo < ActiveRecord::Base
  belongs_to :order
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

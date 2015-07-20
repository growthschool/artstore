# == Schema Information
#
# Table name: order_items
#
#  id           :integer          not null, primary key
#  order_id     :integer
#  product_name :string
#  price        :integer
#  quantity     :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class OrderItem < ActiveRecord::Base
  belongs_to :order
end

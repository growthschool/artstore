require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

# == Schema Information
#
# Table name: orders
#
#  id             :integer          not null, primary key
#  user_id        :integer
#  total          :integer          default("0")
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  token          :string
#  payment_method :string
#  aasm_state     :string           default("order_placed")
#  is_paid        :boolean          default("f")
#
# Indexes
#
#  index_orders_on_aasm_state  (aasm_state)
#  index_orders_on_token       (token)
#

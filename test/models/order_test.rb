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
#  id         :integer          not null, primary key
#  user_id    :integer
#  total      :integer
#  paid       :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  token      :string
#  is_paid    :boolean          default("f")
#
# Indexes
#
#  index_orders_on_token  (token)
#

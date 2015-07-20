class Order < ActiveRecord::Base
  belongs_to :user

  has_one :info, class_name: "OrderInfo", dependent: :destroy

  accepts_nested_attributes_for :info
end

# == Schema Information
#
# Table name: orders
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  total      :integer          default(0)
#  paid       :boolean          default(FALSE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

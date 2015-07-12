class Order < ActiveRecord::Base
end

# == Schema Information
#
# Table name: orders
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  total      :integer          default("0")
#  paid       :boolean          default("f")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

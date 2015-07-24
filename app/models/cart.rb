class Cart < ActiveRecord::Base
  has_many :cart_items, dependent: :destroy
  has_many :items, through: :cart_items, source: :product
end

# == Schema Information
#
# Table name: carts
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

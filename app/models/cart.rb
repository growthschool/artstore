class Cart < ActiveRecord::Base
  def add_product_to_cart(product)
    items << product
  end

end

# == Schema Information
#
# Table name: carts
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#


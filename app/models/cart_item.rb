# == Schema Information
#
# Table name: cart_items
#
#  id         :integer          not null, primary key
#  cart_id    :integer
#  product_id :integer
#  quantity   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_cart_items_on_cart_id     (cart_id)
#  index_cart_items_on_product_id  (product_id)
#

class CartItem < ActiveRecord::Base
  belongs_to :cart
  belongs_to :product

  def reduce_quantity
    self.product.update_attribute(:quantity, (self.product.quantity - self.quantity))
  end
end

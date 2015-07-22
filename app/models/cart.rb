class Cart < ActiveRecord::Base

  has_many :cart_items, :dependent => :destroy
  has_many :items, :through => :cart_items, :source => :product


  def add_product_to_cart(product, amount)
    cart_item = cart_items.build
    cart_item.product = product
    cart_item.quantity = amount
    cart_item.save
  end

  def total_price
    cart_items.inject(0) {|sum, item| sum + (item.product.price * item.quantity) }
  end

  def clean!
    cart_items.destroy_all
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

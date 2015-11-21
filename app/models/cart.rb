class Cart < ActiveRecord::Base
 has_many :cart_items, dependent: :destroy
 has_many :items, through: :cart_items, source: :product

 def total_price
   cart_items.inject(0) { |sum, item| sum + (item.product.price * item.quantity) }
 end

 def add_product_to_cart(product)
   items << product
 end

 def clean!
   cart_items.destroy_all
 end
end

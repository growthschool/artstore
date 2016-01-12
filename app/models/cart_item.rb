class CartItem < ActiveRecord::Base
 belongs_to :cart
 belongs_to :product

 after_save :reduce_to_quantity
 after_destroy :return_to_quantity

 def reduce_to_quantity
   product.quantity -= self.quantity
   product.save
 end

 def return_to_quantity
   product.quantity += self.quantity
   product.save
 end
end

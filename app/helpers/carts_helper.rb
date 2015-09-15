module CartsHelper
	def render_cart_total_price(cart)
		cart.total_price
	end
	
	def render_cart_items_count(cart)
  		cart.cart_items.count
  	end
end

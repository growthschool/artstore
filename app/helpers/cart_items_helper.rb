module CartItemsHelper
	def render_item_sub_total_price(item)
  		item.quantity * item.product.price
  	end
end

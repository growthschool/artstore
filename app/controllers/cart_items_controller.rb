class CartItemsController < ApplicationController
	before_action :authenticate_user!

	def destroy
		@cart = current_cart
		@item = @cart.cart_items.find_by(product_id: params[:id])
	end
end

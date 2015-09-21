class CartItemsController < ApplicationController
	
	before_action :authenticate_user!

	def destroy
		@cart = current_cart
		@cart_item = @cart.cart_items.find(params[:id])
		if @cart_item
			@product = @cart_item.product
			@cart_item.destroy
			flash[:warning] = "此項商品 #{@product.title} 從購物車刪除成功"
		else
			flash[:warning] = "購物車內沒有此項商品可以刪除"
		end

		redirect_to :back
	end
end

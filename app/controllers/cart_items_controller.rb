class CartItemsController < ApplicationController
	before_action :authenticate_user!

	def update
		@cart = current_cart
		@item = @cart.cart_items.find(params[:id])
		@item.update(item_params)

		redirect_to :back
	end

	def destroy
		@cart = current_cart
		@item = @cart.cart_items.find(params[:id])
		@product = @item.product
		@item.destroy

		flash[:warning] = "#{@product.title} 已從購物車刪除！"
		redirect_to :back
	end

	private
		def item_params
			params.require(:cart_item).permit(:quantity)
		end
end

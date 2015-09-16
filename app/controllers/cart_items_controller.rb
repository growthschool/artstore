class CartItemsController < ApplicationController
	before_action :authenticate_user!

	def update
		@cart = current_cart
		@item = @cart.cart_items.find(params[:id])
		
		if @item.product.quantity >= item_params[:quantity].to_i
			#subtotal = @item.product.price * @item.quantity
			@item.update(item_params)
		else
			flash[:warning] = "#{@item.product.title} 庫存數量不足！"			
		end

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
			params.require(:cart_item).permit(:quantity, :subtotal)
		end
end

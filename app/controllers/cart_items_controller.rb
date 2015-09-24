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

	def update
		@cart = current_cart
		@item = @cart.cart_items.find(params[:id])
		@product = @item.product
		old_quantity = @item.quantity
		new_quantity = cart_item_params[:quantity].to_i
		quantity_changed = new_quantity - old_quantity

		if (quantity_changed <= @product.quantity)
			@item.update(cart_item_params)

			@product.quantity -= quantity_changed 
			@product.save
			flash[:notice] = "商品數量更新完成"
		else
			not_enough = quantity_changed - @product.quantity
			flash[:danger] = "商品不足 #{not_enough} 個，請重新選擇數量"
		end
		
		redirect_to carts_path
	end

	private

	def cart_item_params
		params.require(:cart_item).permit(:quantity)
	end
end

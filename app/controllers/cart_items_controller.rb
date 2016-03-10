class CartItemsController < ApplicationController

def update
  @cart = current_cart
  @item = @cart.cart_items.find_by(product_id: params[:id])

  if @item.product.quantity >= item_params[:quantity].to_i

  @item.update(item_params)

  flash[:notice] = "成功變更數量"
   else
     flash[:warning] = "數量不足以加入購物車"
   end

  redirect_to carts_path
end

private

  def item_params
    params.require(:cart_item).permit(:quantity)
  end
end

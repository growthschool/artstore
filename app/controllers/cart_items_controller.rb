class CartItemsController < ApplicationController
  before_action :authenticate_user!

  def destroy
    puts current_cart.cart_items
    @item = current_cart.cart_items.find(params[:id])
    @product = @item.product
    @item.destroy

    flash[:warning] = "成功將 #{@product.title} 從購物車刪除！"
    redirect_to :back
  end

  def update
    @item = current_cart.cart_items.find(params[:id])
    @item.update(item_params)
    redirect_to carts_url
  end

  private

  def item_params
    params.require(:cart_item).permit(:quantity)
  end
end

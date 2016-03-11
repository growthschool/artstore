class CartItemsController < ApplicationController

  def update
    @cart = current_cart
    @item = @cart.find_cart_item(params[:id])
    if @item.product.quantity >= @item.quantity
      @item.update(item_params)
      flash[:notice] = "成功加入購物車"
    else
      flash[:warning] = "庫存不足"
    end
      redirect_to carts_path
end
  def destroy
    @item = current_cart.find_cart_item(params[:id])
    @product = @item.product
    @item.destroy
    redirect_to :back, notice: "已經將#{@product.title}刪除"

  end
  private
  def item_params
    params.require(:cart_item).permit(:quantity)
  end
end

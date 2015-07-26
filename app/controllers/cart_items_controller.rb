class CartItemsController < ApplicationController
  before_action :authenticate_user!
  def destroy
    @cart = current_cart
    @item = @cart.cart_items.find(params[:id])
    @product = @item.product
    @item.destroy
    flash[:success] = "成功從購物車中移除 #{@product.title}"
    redirect_to :back
  end

  def update
    @cart = current_cart
    @item = @cart.cart_items.find(params[:id])
    if @item.product.quantity >= (params[:cart_item][:quantity]).to_i
      @item.update(item_params)
      flash[:success] = "數量已變更"
    else
      flash[:danger] = "數量不足以加入購物車"
    end
    
    redirect_to carts_path
  end

  private
  
  def item_params
    params.require(:cart_item).permit(:quantity)
  end

end

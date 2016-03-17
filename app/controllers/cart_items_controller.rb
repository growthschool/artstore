class CartItemsController < ApplicationController
  before_action :authenticate_user!

  def destroy
    @cart = current_cart
    @item = @cart.cart_items.find_by(product_id: params[:id])
    @product = @item.product
    @item.destroy

    flash[:warning] = "你已把 #{@product.title} 從購物車中刪除"
    redirect_to :back
  end

  def update
    @cart = current_cart
    @item = @cart.cart_items.find_by(product_id: params[:id])

    if @item.product.quantity >= item_params[:quantity].to_i
      @item.update(item_params)
      redirect_to carts_path
    else
      flash[:notice] = "數量不足"
    end
  end

  private

  def item_params
    params.require(:cart_item).permit(:quantity)
  end


end

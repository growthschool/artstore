class CartItemsController < ApplicationController
  before_action :authenticate_user!
  def destroy
    @cart = current_cart
    @item = current_cart.cart_items.find_by(product_id:params[:id])
    @product = @item.product
    @item.destroy
    flash[:warning] = "已將 #{@product.title} 從購物車移除"
    redirect_to :back
  end
  # def destroy
  #   cart = current_cart
  #   item = current_cart.cart_items.find_by(product_id:params[:id])
  #   product = item.product
  #   item.destroy
  #   flash[:warning] = "已將 #{product.title} 從購物車移除"
  #   redirect_to :back
  # end

  def update
    @cart = current_cart
    @item = @cart.cart_items.find_by(product_id:params[:id])
    if @item.product.quantity >= item_params[:quantity].to_i
      @item.update(item_params)
      flash[:warning] = "成功變更數量"
    else
      flash[:warning] = "#{@item.product.title}庫存僅剩#{@item.product.quantity}件"
    end

    redirect_to carts_path
  end

  private
  def item_params
    params.require(:cart_item).permit(:quantity)
  end
end

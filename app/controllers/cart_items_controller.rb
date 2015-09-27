class CartItemsController < ApplicationController

  def destroy
    @cart = current_cart
    @item = @cart.find_cart_item(params[:id])  #找出product_id = params[:id]的item
    @product = @item.product

    @item.destroy
    flash[:warning] ="成功將#{@product.title}從購物車刪除"
    redirect_to :back

  end

  def update
    @cart = current_cart
    @item = @cart.find_cart_item(params[:id])


    if @item.product.quantity >= item_params[:quantity].to_i  #item_params[:quantity]代表欲變更的數量
      @item.update(item_params)
      flash[:notice] = "成功變更數量"
    else
      flash[:waring] = "數量不足，無法加入購物車"
    end
    redirect_to carts_path

  end


  private

  def item_params
    params.require(:cart_item).permit(:quantity)
  end
end

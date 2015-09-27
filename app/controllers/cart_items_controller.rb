class CartItemsController < ApplicationController
before_action :authenticate_user!

  def destroy
    @cart = current_cart
    @item = @cart.cart_items.find_by(product_id: params[:id])
    @product = @item.product
    @item.destroy

    flash[:warning] = "以成功將#{@product.title} 從購物車中刪除"
    redirect_to :back

  end


end

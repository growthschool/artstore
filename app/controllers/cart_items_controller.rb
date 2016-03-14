class CartItemsController < ApplicationController
  before_action :authenticate_user!

  def destroy
    @item = current_cart.cart_items.find_by(product_id: params[:id])
    @product = @item.product
    @item.destroy

    flash[:warning] = "成功將 #{@product.title} 從購物車中刪除！"
    redirect_to :back
  end

end

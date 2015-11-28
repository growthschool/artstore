class CartItemsController < ApplicationController
  before_action :authenticate_user!

  def destroy
    #params[:id] is product id
    item = current_cart.cart_items.find_by(product_id: params[:id])
    product_title = item.product.title
    item.destroy

    flash[:warning] = "成功將 #{product_title} 從購物車刪除!"
    redirect_to :back
  end
end

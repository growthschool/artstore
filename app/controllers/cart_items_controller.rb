class CartItemsController < ApplicationController
  before_action :authenticate_user!

  def update
    #params[:id] is product id
    item = current_cart.cart_items.find_by(product_id: params[:id])

    item.update(cart_item_params)

    #item.quantity = cart_item_params[:quantity]
    #item.save

    redirect_to :back
  end

  def destroy
    #params[:id] is product id
    item = current_cart.cart_items.find_by(product_id: params[:id])
    product_title = item.product.title
    item.destroy

    flash[:warning] = "成功將 #{product_title} 從購物車刪除!"
    redirect_to :back
  end

  private
  def cart_item_params
    params.require(:cart_item).permit(:quantity)
  end
end

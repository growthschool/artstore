class CartItemsController < ApplicationController
  def update
    cart_item = current_cart.cart_items.find(params[:id])
    if cart_item.update_attributes(cart_item_params)
      redirect_to carts_url, notice: 'Quantity updated!'
    else
      flash.now[:alert] = 'Quantity updated failed!'
      render 'carts/index'
    end
  end

  def destroy
    cart_item = current_cart.cart_items.find(params[:id])
    cart_item.destroy
    redirect_to carts_url, notice: 'Item deleted.'
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:quantity)
  end
end

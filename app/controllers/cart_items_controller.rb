class CartItemsController < ApplicationController
  before_action :authenticate_user!

  def destroy
    @cart = current_cart
    @item = @cart.find_cart_item(params[:id])
    @product = @item.product
    @item.destroy

    flash[:warning] = "Successfully delete #{product.title} from shopping cart."
    redirect_to :back
  end

  def update
    @cart = current_cart
    @item = @cart.cart_items.find_by(product_id: params[:id])

    if @item.product.quantity > 0
      @item.update(items_params)
      flash[:notice] = "Successfully change quantity"
    else
      flash[:warning] = "Quantity is not enough"
    end

    redirect_to carts_path
  end

  def items_params
    params.require(:cart_item).permit(:quantity)
  end
end

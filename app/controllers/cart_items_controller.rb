class CartItemsController < ApplicationController
  def update
    @cart_item = current_cart.cart_items.find(params[:id])

    if @cart_item.product.quantity >= @cart_item.quantity
      @cart_item.update(item_params)
      flash[:notice] = 'Quantity updated'
    else
      flash[:alert] = 'The remain goods is not enough.'
    end

    redirect_to carts_path
  end

  def destroy
    @cart_item = current_cart.cart_items.find(params[:id])
    @product = current_cart.items.find(@cart_item.product_id)
    @cart_item.destroy
    flash[:warning] = "Item #{@product.title} has been removed."
    redirect_to :back
  end

  private
    def item_params
      params.require(:cart_item).permit(:quantity)
    end
end

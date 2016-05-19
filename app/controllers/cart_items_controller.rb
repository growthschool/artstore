class CartItemsController < ApplicationController

  before_action :authenticate_user!


  def update
    @cart = current_cart
    @item = @cart.cart_items.find_by(product_id: params[:id])

    if @item.product.quantity >= item_params[:quantity].to_i
      @item.update(item_params)
      flash[:notice] = "Updated total amount."
    else
      flash[:warning] = "Not enough in stock. Can't add to shopping cart."
    end

    redirect_to carts_path
  end


  def destroy
    @cart = current_cart
    @item = @cart.find_cart_item(params[:id])
    @product = @item.product
    @item.destroy

    flash[:warning] = "Successfully remove #{@product.title} from shopping cart."
    redirect_to :back
  end

  private

  def item_params
    params.require(:cart_item).permit(:quantity)
  end

end

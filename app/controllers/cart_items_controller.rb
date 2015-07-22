class CartItemsController < ApplicationController

   before_action :authenticate_user!

  def destroy
    @cart = current_cart
    @item = @cart.cart_items.find(params[:id])
    @product = @item.product
    @item.destroy

    flash[:warning] = "成功將 #{@product.title} 從購物車刪除!"
    redirect_to :back

  end


  def update
    
    @cart = current_cart
    @item = @cart.cart_items.find(params[:id])

    #item_params            ActionController::Parameters    ("quantity"=>"2"}
    #item_params[:quantity] String                          "2"

    if @item.product.quantity >= item_params[:quantity].to_i 
      @item.update(item_params)
      flash[:notice] = "成功變更數量!"
    else
      flash[:warning] = "購買數量不得超過庫存的數量!"
    end

    redirect_to carts_path
  end


  private

  def item_params
    params.require(:cart_item).permit(:quantity)
  end


end

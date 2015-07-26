class CartsController < ApplicationController
  before_action :authenticate_user!, :only => [:checkout]

  def index
  end

  def checkout
    @order = current_user.orders.build
    @info = @order.build_info
  end

  def destroy
  	
  end

  def clean
    current_cart.cart_items.destroy_all
    flash[:warning] = "購物車已清空"
    redirect_to carts_path
  end
end

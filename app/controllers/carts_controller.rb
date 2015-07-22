class CartsController < ApplicationController
  
  before_action :authenticate_user!, :only => [:checkout]
 
  def index
  end
 
  def checkout
    @order = current_user.orders.build
    @info = @order.build_info
  end

  def clean
    current_cart.clean! # 因為has_many :cart_items 所以用destroy_all
    flash[:warning] = "已清空購物車"
    redirect_to carts_path
  end

end

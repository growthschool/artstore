class CartsController < ApplicationController
  before_action :authenticate_user!, :only => [:checkout]

  def index
  end

  def checkout
    @order = current_user.orders.build
    @info = @order.build_info
  end

  def destroy
    current_cart.destroy
    redirect_to carts_path
  end
end

class CartsController < ApplicationController
  before_action :authenticate_user!, only: [:checkout]

  def index
    @cart = Cart.find(session[:cart_id])
  end

  def checkout
    @order = current_user.orders.build
    @info = @order.build_info
  end
end

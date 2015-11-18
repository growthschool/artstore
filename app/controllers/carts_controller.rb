class CartsController < ApplicationController
  before_action :authenticate_user!, only: [:checkout]

  def checkout
    @order = current_cart.orders.build
    @info = @order.build_info
  end
end

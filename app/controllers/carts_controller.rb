class CartsController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def checkout
    @order = current_user.orders.build
    @info = @order.build_info
  end
end

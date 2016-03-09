class CartsController < ApplicationController

  def index

  end

  def checkout
    @order = current_user.order.build
    @info = @order.build_info #has_one才有的
  end
end

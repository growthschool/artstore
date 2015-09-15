class CartsController < ApplicationController
  before_action :authenticate_user!, only: [:checkout]

  def index
    @cart = current_cart
  end

  def clean
    cart = Cart.find_by(id: session[:cart_id])
    if cart.nil?
      redirect_to root_url, warning: 'No shopping cart.'
    else
      cart.destroy
      redirect_to carts_url, notice: 'Cart cleaned.'
    end
  end

  def checkout
    @order = current_user.orders.build
    @info = @order.build_info
  end
end

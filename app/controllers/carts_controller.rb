class CartsController < ApplicationController
  def index
    @cart = Cart.find(session[:cart_id])
  end
end

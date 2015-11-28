class Admin::OrdersController < ApplicationController
  layout "admin"
  before_action :authenticate_user!
  before_action :admin_required

  def index
    @orders = Order.order("id DESC")
  end

  def show
    @order = Order.find_by(token: params[:id])
  end

  def cancel
    @order = Order.find_by(token: params[:id])
    @order.cancel_order!
    redirect_to admin_order_path(@order.token)
  end

  def paid
    @order = Order.find_by(token: params[:id])
    @order.make_payment!
    redirect_to admin_order_path(@order.token)
  end

  def ship
    @order = Order.find_by(token: params[:id])
    @order.ship!
    redirect_to admin_order_path(@order.token)
  end

  def shipped
    @order = Order.find_by(token: params[:id])
    @order.deliver!
    redirect_to admin_order_path(@order.token)
  end

  def return
    @order = Order.find_by(token: params[:id])
    @order.return_good!
    redirect_to admin_order_path(@order.token)
  end

end

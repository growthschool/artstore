class Admin::OrdersController < ApplicationController
    before_action :authenticate_user!
    before_action :admin_required
  def index
    @orders = Order.recent
  end

  def show
    @order = Order.find_by_token(params[:id])
    @order_items = @order.items
    @order_info = @order.info
  end

  def ship
    @order = Order.find(params[:id])
    @order.ship!
    redirect_to :back
  end

  def shipped
    @order = Order.find(params[:id])
    @order.deliver!
    redirect_to :back
  end

  def return
    @order = Order.find(params[:id])
    @order.return_good!
    redirect_to :back
  end

  def cancel
    @order = Order.find(params[:id])
    @order.cancel_order!
    redirect_to :back
  end


end

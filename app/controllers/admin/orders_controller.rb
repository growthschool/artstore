class Admin::OrdersController < ApplicationController
	layout "admin"

  before_action :authenticate_user!
  before_action :admin_required

  def index
    @orders = Order.order("id DESC")
    #@orders = Order.recent
  end

  def show
  	@order = Order.find(params[:id])
  	@order_info = @order.info   
  	#在html裡其實也可以直接使用@order.info 但是每用一次系統就會呼叫一次表單 增加系統負擔
    @order_items = @order.items
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

  def cancel
    @order = Order.find(params[:id])
    @order.cancell_order!
    redirect_to :back
  end

  def return
    @order = Order.find(params[:id])
    @order.return_good!
    redirect_to :back
  end
end

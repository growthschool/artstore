class Admin::OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_required
  before_action :find_order , only:[:ship,:shipped,:cancel,:return]

  def index
    @orders = Order.order("id DESC")
  end

  def show
    @order = Order.find(params[:id])
    @order_info = @order.info
    @order_items = @order.items
  end

  def ship

    @order.ship!
    redirect
  end
  def shipped
    @order.deliver!
    redirect
  end
  def cancel
    @order.cancell_order!
    redirect
  end
  def return
    @order.return_good!
    redirect
  end


  private
  def find_order
    @order = Order.find(params[:id])
  end

  def redirect
    redirect_to :back
  end
end

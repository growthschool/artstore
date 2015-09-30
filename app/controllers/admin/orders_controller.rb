class Admin::OrdersController < AdminController
  def index
    @orders = Order.recent
  end

  def show
    @order = Order.find(params[:id])
    @order_items = @order.items
    @order_info = @order.info
  end

  def update_state
    @order = Order.find(params[:id])
    if @order.update_state(params[:event])
      flash[:notice] = 'State updated!'
    else
      flash[:alert] = 'State updated failed!'
    end
    redirect_to admin_orders_url
  end
end

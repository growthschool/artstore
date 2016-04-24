class OrdersController < ApplicationController
  before_action :authenticate_user!

  def create
    @order = current_user.orders.build(order_params)

    if @order.save
      @order.build_item_cache_from_cart(current_cart)
      @order.calculate_total!(current_cart)
      current_cart.clean!
      redirect_to order_path(@order)
    else
      render "carts/checkout"
    end
  end

  #注意.或_
  def show
    @order = Order.find(params[:id])
    @order_info = @order.info
    @order_items = @order.items
  end


  private

  def order_params
    params.require(:order).permit(info_attributes: [:billing_name,
                                                    :billing_address,
                                                    :shipping_name,
                                                    :shipping_address])
  end
end

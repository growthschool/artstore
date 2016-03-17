class OrdersController < ApplicationController
  before_action :authenticate_user!
  def create
    @order = current_user.orders.build(order_params)
    
  end

  private
  def order_params
    params.require(:order).permit(info_attributes:[
      :billing_name,
      :billing_address,
      :shipping_name,
      :shipping_address
      ])
  end
end

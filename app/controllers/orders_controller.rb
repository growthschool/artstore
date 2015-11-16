class OrdersController < ApplicationController
  before_action :authenticate_user!

  def create
    @order = current_user.orders.build(order_params)

    if @order.save
      @order.build_item_cache_from_cart(current_cart)
      @order.calculate_total!(current_cart)
      #redirect_to order_path(@order) 訂單編碼顯示在網址中太危險了
      redirect_to order_path(@order.token) #將隨機產生的token取代網址編碼
    else
      render "carts/checkout"
    end
end

def show
  # @order = Order.find(params[:id])
   @order = Order.find_by_token(params[:id])
   @order_info = @order.info
   @order_items = @order.items
 end

def pay_with_credit_card
  @order = Order.find_by_token(params[:id])
  @order.set_payment_with!("credit_card")
  @order.make_payment!

  redirect_to "/", notice: "成功完成付款"
end
private

def order_params
  params.require(:order).permit(info_attributes: [:billing_name,
                                                  :billing_address,
                                                  :shipping_name,
                                                  :shipping_address] )
end
end

class OrdersController < ApplicationController

  def create
   @order = current_user.orders.build(order_params)
    if @order.save
      @order.build_item_cache_from_cart(current_cart) #把購物車的東西塞到訂單order_item中
      @order.calculate_total!(current_cart) #把購物車的總價格塞到訂單order的total欄位中
      current_cart.clean!
      redirect_to order_path(@order.token)
    else
      render "carts/checkout"
    end
  end

  def show
    @order = Order.find_by_token(params[:id])
    @order_info = @order.info
    @order_items = @order.items
  end

  def pay_with_credit_card
    @order = Order.find_by_token(params[:id])
    @order.set_payment_with!("credit_card") #更新成使用什麼付費
    @order.make_payment!#更新成已付款
    redirect_to "/", notice: "您已成功付款!!"
  end

  private

  def order_params
    params.require(:order).permit(info_attributes: [:billing_name, :billing_address, :shipping_name, :shipping_address])
  end
end

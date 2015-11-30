class OrdersController < ApplicationController
  before_action :authenticate_user!, except: :pay2go_cc_notifty

  protect_from_forgery except: :pay2go_cc_notify

  def create
    @order = current_user.orders.build(order_params)

    if @order.save
      OrderPlacingService.new(current_cart, @order).place_order!).deliver!

      redirect_to order_path(@order.token)
    else
      render "carts/checkout"     # 退到不同的controller時, 複用templates
    end

  end

  def show
    @order = Order.find_by_token(params[:id])
    @order_info = @order.info
    @order_items = @order.items
  end


  def pay_with_credit_card
    @order = Order.find_by_token(params[:id])
    @order.set_payment_with!("credit_card")
    @order.make_payment!

    redirect_to account_orders_path, notice: "成功完成付款"
  end

  def pay2go_cc_notify
    @order = Order.find_by_token(params[:id])
    if params["Status"] == "SUCCESS"
    @order.make_payment!

    if @order.is_paid?
      flash[:notice] = "信用卡付款成功"
      redirect_to account_orders_path
    else
      render text: "信用卡失敗"
    end

    else
      render text: "交易失敗"
    end
  end

  private

  def order_params
    params.require(:order).permit(info_attributes: [:billing_name,
                                                    :billing_address,
                                                    :shipping_name,
                                                    :shipping_address] )
  end
end

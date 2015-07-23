module Admin::OrdersHelper

  def render_order_options_for_admin(order)
    render :partial => "admin/orders/state_option", :locals => { :order => order}
  end

  def render_order_paid_state(order)
    if order.paid?
      "已付款"
    else
      "未付款"
    end
  end

end

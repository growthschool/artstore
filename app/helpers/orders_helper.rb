module OrdersHelper
  def render_order_state(order)
    t("orders.order_state.#{order.aasm_state}")
  end

  def render_order_paid_state(order)
    if order.paid?
      "已付款"
    else
      order_state = render_order_state(order)
      "未付款 - #{order_state}"
    end

  end
end

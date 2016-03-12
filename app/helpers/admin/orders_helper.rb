module Admin::OrdersHelper
  def render_order_state(order)
    t("orders.order_state.#{order.aasm_state}")
  end

  def render_order_paid_state(order)
    if order.is_paid?
      return "已付款"
    else
      return "未付款"
    end
  end
end

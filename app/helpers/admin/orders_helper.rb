module Admin::OrdersHelper
  def render_order_state(order)
    t("orders.order_state.#{order.aasm_state}")
  end

  def render_order_options_for_admin(order)
    render partial: "admin/orders/state_option", locals: {order: order}
  end

  def render_order_paid_state(order)
    if order.is_paid?
      "已付款"
    else
      "未付款"
    end
  end
end

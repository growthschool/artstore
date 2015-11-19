module OrdersHelper
  def render_order_state(order)
    t("orders.order_state.#{order.aasm_state}")
  end
end

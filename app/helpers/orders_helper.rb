module OrdersHelper
  def render_order_total_price(order)
    order.total_price
  end

  def render_order_state(order)
    t("orders.order_state.#{order.aasm_state}")
  end
end

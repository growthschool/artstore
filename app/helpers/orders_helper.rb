module OrdersHelper
  def render_order_timestamp(order)
    order.created_at.to_s(:long)
  end

  def render_order_state(order)
    t("orders.order_state.#{order.aasm_state}")
  end

  def render_order_paid_state(order)
    order.is_paid? ? 'paid' : 'not paid'
  end
end

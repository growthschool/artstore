module OrdersHelper

  def render_order_timestamp(order)
    order.created_at.to_s(:long)
  end

  def render_order_state(order)
    t("orders.order_state.#{order.aasm_state}") #i18
  end

  def render_order_paid_state(order)
    if order.is_paid? #paid? is_paid?
      "已付款"
    else
      "未付款"
    end

  end

end

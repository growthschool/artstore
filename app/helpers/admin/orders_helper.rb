module Admin::OrdersHelper
  def render_order_paid_state(order)
    if order.is_paid?
      'Piad'
    else
      'Unpaid'
    end
  end
end

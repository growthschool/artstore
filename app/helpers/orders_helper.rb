module OrdersHelper

  def render_order_timestamp(order)
    order.created_at.to_s(:long)
  end

end

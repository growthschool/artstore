module OrdersHelper
  def render_order_state(order)
    t("orders.order_state.#{order.aasm_state}")
  end

  def render_order_paid_state(order)
    order_state = render_order_state(order)
    if order.is_paid?
      "已付款 - #{order_state}"
    else

      "未付款 - #{order_state}"
    end
  end

  def render_link_to_cancel_order(order)
    link_to("取消訂單", cancel_admin_order_path(order.token), method: :post,
            class: "btn btn-default btn-default")
  end

  def render_link_to_paid_order(order)
    link_to("設為 paid", paid_admin_order_path(order.token), method: :post,
            class: "btn btn-default btn-default")
  end

  def render_link_to_ship_order(order)
    link_to("出貨", ship_admin_order_path(order.token), method: :post,
            class: "btn btn-default btn-default")
  end

  def render_link_to_shipped_order(order)
    link_to("設為已到貨", shipped_admin_order_path(order.token), method: :post,
            class: "btn btn-default btn-default")
  end

  def render_link_to_return_order(order)
    link_to("退貨", return_admin_order_path(order.token), method: :post,
            class: "btn btn-default btn-default")
  end

end

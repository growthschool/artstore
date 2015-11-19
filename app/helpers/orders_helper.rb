module OrdersHelper
  def render_order_state(order)
    t("orders.order_state.#{order.aasm_state}")  # 使用t function, i18n機制 , 到config/application.rb更改預設語言
  end
end

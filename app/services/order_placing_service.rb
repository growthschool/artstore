class OrderPlacingService
  def initialize(cart, order)
    @order = order
    @cart = cart
  end

  def place_order!
    @order.build_item_cache_from_cart(@cart)
    @order.calculate_total!(@cart)
    @cart.clean!
    OrderMailer.notify_order_placed(@order).deliver # mailgun 寄信功能設定完成後再啟用
  end
end

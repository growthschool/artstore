class OrderPlacingService
  def initialize(cart, order)
    @order = order
    @cart = cart
  end

  def place_order!
    @order.build_item_cache_from_cart(@cart)
    @order.calculate_total!(@cart)
    @cart.clean!
    #OrderMailer.notify_order_placed(@order).deliver
    #安裝delayed_job_active_record後改成下面這行
    OrderMailer.delay.notify_order_placed(@order)

  end
end

class OrderPlacingService
  def initialize(cart, order)
    @order = order
    @cart = cart
  end

  def place_order!
    @order.build_item_cache_from_cart(@cart)
    @order.caculate_total!(@cart)
    @cart.destroy
    OrderMailer.notify_order_placed(@order).deliver
  end
end

class OrderPlacingService
  def initialize(cart, order)
    @order = order
    @cart = cart
  end

  def place_order!
    @order.build_item_cache_from_cart(@cart)
    @order.calculate_total!(@cart)
    @cart.cart_items.destroy_all
    #OrderMailer.notify_order_placed(@order).deliver
    OrderMailer.delay.notify_order_placed(@order)
  end
end
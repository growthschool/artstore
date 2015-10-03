class OrderPlacingService
  def initialize(cart, order)
    @cart = cart
    @order = order
  end

  def place_order!
      @order.build_item_cache_from_cart(@cart)
      @order.calculate_total!(@cart)
      OrderMailer.notify_order_placed(@order).deliver
      @cart.cart_items.destroy_all

  end

end

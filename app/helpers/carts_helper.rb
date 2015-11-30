module CartsHelper
  def render_cart_total_price(cart)
    cart.total_price
  end
  def render_cart_subtotal_price(cart)
    cart.subtotal_price
  end

end

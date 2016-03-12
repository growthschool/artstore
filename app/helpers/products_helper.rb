module ProductsHelper
  def render_cart_items_count(cart)
    cart.items.count
  end
end

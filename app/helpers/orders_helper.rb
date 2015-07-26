module OrdersHelper
  def render_order_timestamp(order)
    order.created_at.to_s(:long)
  end

  def reduce_product_quantity!
    current_cart.cart_items.each do |cart_item|
    cart_item.reduce_quantity
    end
  end
end

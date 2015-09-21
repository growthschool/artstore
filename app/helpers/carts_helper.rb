module CartsHelper
  def render_cart_total_price(cart)
    cart.total_price
  end
  def render_check_button
    link_to_if(current_cart.hasItem?, "確認結賬", checkout_carts_path, method: :post, class: "btn btn-lg btn-danger pull-right") do
      link_to("尚未選購商品", "#", class: "btn btn-lg pull-right btn-disabled")
    end
  end
  def render_clear_button
    if current_cart.hasItem?
      link_to("清空購物車", clean_carts_path, method: :delete, class: "btn btn-danger btn-sm", data:{confirm: "你確定要清空整個購物車嗎？"})
    end
  end
  def render_cart_item_price(item)
    item.sum
  end
end

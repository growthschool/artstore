module ApplicationHelper

  def notice_message
    class_names = {alert: :danger, notice: :success, info: :success, warning: :warning}

    close_text = content_tag(:span, "x", html_options = { "aria-hidden" => "true" })
    close_button = content_tag(:button, close_text, html_options = {type: "button", class: "close", "data-dismiss" => "alert", "aria-label" => "Close"})

    messages = flash.map do |flash_type, flash_msg|
      msg_body = close_button + flash_msg
      msg_class = class_names[flash_type.to_sym] || flash_type

      content_tag(:div, msg_body, html_options = { class: "alert alert-#{msg_class} alert-dismissible", role: "alert" } )
    end

    messages.join("\n").html_safe
  end

  def render_cart_items_count(cart)
    cart.cart_items.count
  end

end

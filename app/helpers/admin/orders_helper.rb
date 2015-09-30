module Admin::OrdersHelper
  def render_order_events(order)
    if order.aasm.events.empty?
      return content_tag(:span, render_order_state(order), class: 'label label-default')
    end

    btn_array = order.aasm.events.map do |event|
      event_name = event.name.to_s
      btn_name = event_name.gsub('_', ' ').capitalize
      link_to(btn_name,
        update_state_admin_order_path(order, event: event_name),
        method: :patch,
        class: 'btn btn-primary')
    end
    btn_array.join("\n").html_safe
  end
end

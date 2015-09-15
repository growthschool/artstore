module Admin::OrdersHelper
  def render_order_events(order)
    content_tag :ul do
      btn_array = order.aasm.events.map do |event|
        event_name = event.name.to_s
        btn_name = event_name.gsub('_', ' ').capitalize
        content_tag(:li, link_to(btn_name,
          update_state_admin_order_path(order, event: event_name),
          method: :patch,
          class: 'btn btn-primary')
        )
      end
      btn_array.join("\n").html_safe
    end
  end
end

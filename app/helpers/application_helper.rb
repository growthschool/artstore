module ApplicationHelper
  def notice_message
    alert_types = { notice: :success, alert: :danger }

    close_button_options = { class: 'close', 'data-dismiss' => 'alert',
      'aria-label' => 'Close', 'aria-hidden' => 'true' }
    close_button = content_tag(:button, 'x', close_button_options)

    alerts = flash.map do |msg_type, msg|
      alert_content = close_button + msg
      current_alert_type = alert_types[msg_type.to_sym] || msg_type
      alert_class = "alert alert-#{current_alert_type} alert-dismissable"
      content_tag(:div, alert_content, class: alert_class)
    end

    alerts.join("\n").html_safe
  end
end

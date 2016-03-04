module ApplicationHelper
  def notice_message
    alert_types = { notice: :success, alert: :danger }

    options = { class: 'close', 'data-dismiss' => 'alert', 'aria-hidden' => true }
    btn = content_tag(:button, 'x', options)

    alerts = flash.map do |type, msg|
      alert_content = btn + msg
      alert_type = alert_types[type.to_sym] || type
      alert_class = "alert alert-#{alert_type} alert-dismissable"
      content_tag(:div, alert_content, class: alert_class)
    end

    alerts.join("\n").html_safe
  end
end

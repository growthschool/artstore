module ApplicationHelper
  def notify_message
    alert_types = { notice: :success, alert: :danger }
    close_button_option = { class: "close", "data-dismiss" => "alert", "aria-hidden" => true }
    close_button = content_tag :button, "x", close_button_option
    
    alerts = flash.map do |key, value|
      alert_content = close_button + value
      alert_type = alert_types[key.to_sym] || key
      alert_class = "alert alert-#{alert_type} alert-dismissable"
      content_tag :div, alert_content, class: alert_class
    end
    
    alerts.join("\n").html_safe
  end
end

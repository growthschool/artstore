module ApplicationHelper
  # def notify_message
#     alert_types = { notice: :success, alert: :danger }
#     close_button_option = { class: "close", "data-dismiss" => "alert", "aria-hidden" => true }
#     close_button = content_tag :button, "x", close_button_option
#
#     alerts = flash.map do |key, value|
#       alert_content = close_button + value
#       alert_type = alert_types[key.to_sym] || key
#       alert_class = "alert alert-#{alert_type} alert-dismissable"
#       content_tag :div, alert_content, class: alert_class
#     end
#
#     alerts.join("\n").html_safe
#   end
  
  def notify_message
    flash_types = { notice: :info, alert: :warning, error: :danger }
    
    close_button_option = { class: "close", "data-dismiss" => "alert", "aria-hidden" => true }
    close_button = content_tag :button, "close", close_button_option
    
    alerts = flash.map do |key, value|
      flash_type = flash_types[key.to_sym] || key
      flash_content = close_button + value
      alert_class = "alert alert-#{flash_type} alert-dismissable"
      content_tag :div, flash_content, class: alert_class
    end
    
    alerts.join("\n").html_safe
  end
end

class OrderMailer < ApplicationMailer

  def notify_order_placed(order)
    @order = order
    @user = order.user
    @order_items = @order.items
    @order_info = @order.info

    mail(to: @user.email, subject: "[Artstore] 感謝您完成本次下單，以下是您的購物明細 #{order.token}")
  end


end

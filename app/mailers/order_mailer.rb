class OrderMailer < ApplicationMailer
  include Roadie::Rails::Automatic

  def notify_order_placed(order)
    @order = order
    @user = @order.user
    @order_items = @order.items
    @order_info = @order.info

    mail(to: @user.email,
      subject: "[Artstore] Thank you for the order, here is your order info #{order.token}")
  end
end

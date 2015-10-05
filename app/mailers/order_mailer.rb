class OrderMailer < ApplicationMailer
   def notify_order_placed(order)
      @order       = order
      @user        = order.user
      @order_items = @order.items
      @order_info  = @order.info

      mail(to: @user.email , subject: "[Artstore] 感謝您完成本次的下單，以下是您這次購物明細 #{order.token}")
   end
   
   def send_simple_message
      RestClient.post "https://api:key-9c43ef28e6c7f967b80494e9502f3b85"\
      "@api.mailgun.net/v3/sandbox72ea713f621246988696577ca4bdee1f.mailgun.org/messages",
      :from => "Mailgun Sandbox <postmaster@sandbox72ea713f621246988696577ca4bdee1f.mailgun.org>",
      :to => "thor <thorshu@gmail.com>",
      :subject => "Hello thor",
      :text => "Congratulations thor, you just sent an email with Mailgun!  You are truly awesome!  You can see a record of this email in your logs: https://mailgun.com/cp/log .  You can send up to 300 emails/day from this sandbox server.  Next, you should add your own domain so you can send 10,000 emails/month for free."
   end
end

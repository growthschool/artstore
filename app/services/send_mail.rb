def send_simple_message
  RestClient.post "https://api:key-ceaf6e03ab1a133bb47eba638f80c0a8"\
  "@api.mailgun.net/v3/sandbox6f4ec63c9d9e4f73a4c8e3035a6c1d36.mailgun.org/messages",
  :from => "Mailgun Sandbox <postmaster@sandbox6f4ec63c9d9e4f73a4c8e3035a6c1d36.mailgun.org>",
  :to => "Jimmy Pan <jimmypan@gmail.com>",
  :subject => "Hello Jimmy Pan",
  :text => "Congratulations Jimmy Pan, you just sent an email with Mailgun!  You are truly awesome!  You can see a record of this email in your logs: https://mailgun.com/cp/log .  You can send up to 300 emails/day from this sandbox server.  Next, you should add your own domain so you can send 10,000 emails/month for free."
end
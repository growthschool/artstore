class ApplicationMailer < ActionMailer::Base
  # default from: "from@example.com"
  default from: "service@artstore.com"
  layout 'mailer'
end

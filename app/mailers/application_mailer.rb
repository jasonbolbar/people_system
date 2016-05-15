class ApplicationMailer < ActionMailer::Base
  default from: "People app <#{Rails.application.secrets[:mailer]['from']}>"
  layout 'mailer'
end

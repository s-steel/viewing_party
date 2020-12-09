class ApplicationMailer < ActionMailer::Base
  default from: 'no-reply@turing.io'
  layout 'mailer'
end

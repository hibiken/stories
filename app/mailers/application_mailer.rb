class ApplicationMailer < ActionMailer::Base
  default from: ENV['MAILER_SENDER'] || "stories@example.com"
  layout 'mailer'
end

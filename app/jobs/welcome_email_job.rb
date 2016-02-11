class WelcomeEmailJob < ActiveJob::Base
  queue_as :mailer

  def perform(user_id)
    user = User.find_by(id: user_id)
    UserMailer.welcome_email(user).deliver_now if user
  end
end

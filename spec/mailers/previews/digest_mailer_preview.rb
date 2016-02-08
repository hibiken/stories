# Preview all emails at http://localhost:3000/rails/mailers/digest_mailer
class DigestMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/digest_mailer/daily_email
  def daily_email
    user = User.first
    DigestMailer.daily_email(user)
  end

end

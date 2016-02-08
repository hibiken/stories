class DigestMailer < ApplicationMailer
  add_template_helper(UsersHelper)
  add_template_helper(PostsHelper)

  def daily_email(user)
    @user = user
    @recommended = Post.top_stories(2)
    mail to: @user.email, subject: "Stories Daily Digest"
  end
end

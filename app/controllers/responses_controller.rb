class ResponsesController < ApplicationController
  before_action :authenticate_user!

  def create
    post = Post.find(params[:post_id])
    if current_user.responses.create(body: params[:response][:body], post_id: post.id)

      # Create the notifications for all commented users and author of post
      (post.responders.uniq - [current_user]).each do |user|
        Notification.create(recipient: user, actor: current_user, action: "also commented on a", notifiable: post, is_new: true)
      end
      #Notify the author
      unless current_user?(post.user)
        Notification.create(recipient: post.user, actor: current_user, action: "responded to your", notifiable: post, is_new: true)
      end

      redirect_to post
    else
      redirect_to post, alert: "You cannot create a blank response!"
    end
  end
end

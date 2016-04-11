class ResponsesController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    @response = current_user.responses.create(body: params[:response][:body], post_id: @post.id)
    if @response.valid?
      notify_author_and_responders
      respond_to do |format|
        format.html { redirect_to @post }
        format.js
      end
    else
      # TODO: display useful error message
      render nothing: true
    end
  end

  private

    def notify_author_and_responders
      (@post.responders.uniq - [current_user]).each do |user|
        Notification.create(recipient: user, actor: current_user, action: "also commented on a", notifiable: @post, is_new: true)
      end
      unless current_user?(@post.user) || @post.responders.include?(@post.user)
        Notification.create(recipient: @post.user, actor: current_user, action: "responded to your", notifiable: @post, is_new: true)
      end
    end
end

class ResponsesController < ApplicationController
  before_action :authenticate_user!

  def create
    post = Post.find(params[:post_id])
    if current_user.responses.create(body: params[:response][:body], post_id: post.id)
      redirect_to post
    else
      redirect_to post, alert: "You cannot create a blank response!"
    end
  end
end

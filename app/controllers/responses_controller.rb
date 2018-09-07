class ResponsesController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    @response = current_user.posts.create(
      body: params[:post][:body], 
      plain: params[:post][:plain],
      parent_id: @post.id,
      published_at: Time.now
    )
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

  def build
    @parent_post = Post.find(params[:post_id])
    @post = current_user.posts.create(
      parent_id: @parent_post.id,
      body: params[:post][:body], 
      plain: params[:post][:plain]
    )

    respond_to do |format|
      format.html { 
        redirect_to edit_post_path(@post)
        #render "posts/new", layout: 'editor' 
      }
      format.js
    end
  end


  def new
    @parent_post = Post.find(params[:post_id])
    @post = current_user.posts.new(
      parent_id: @parent_post.id
    )

    respond_to do |format|
      format.html { render "posts/new", layout: 'editor' }
      format.js
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

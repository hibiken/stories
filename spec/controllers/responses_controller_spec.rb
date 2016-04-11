require "rails_helper"

RSpec.describe ResponsesController do
  describe "Access Control" do
    before :each do
      @post = create(:post)
    end

    describe "POST #create" do
      it "requires a logged-in user" do
        post :create, post_id: @post.id, response: { body: "Great post!" }
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "Happy Path" do
    before :each do
      @author = create(:user)
      @post = create(:post, user: @author)
      @current_user = create(:user)
      login @current_user
    end

    it "allows a logged-in user to create a response" do
      expect{post :create, post_id: @post.id, response: { body: "Great post!" }}.
        to change(Response, :count).by(1)
    end
  end

  describe "Notifying users" do
    before :each do
      @author = create(:user)
      @post = create(:post, user: @author)
      @responder = create(:user)
      @current_user = create(:user)
      @post.responses.create!(body: "Great article", user_id: @responder.id)
      login @current_user
    end

    it "notifies author and all responders" do
      expect{post :create, post_id: @post.id, response: { body: "thanks for this post"}}.
        to change(Notification, :count).by(2)
    end

    it "notifies the author once even if the author is included in responders" do
      @post.responses.create!(body: "Thanks!", user_id: @author.id)
      expect{post :create, post_id: @post.id, response: { body: "Cool post" }}.
        to change(Notification, :count).by(2)
    end
  end
end

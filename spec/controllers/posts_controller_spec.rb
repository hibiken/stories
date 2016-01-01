require "rails_helper"

RSpec.describe PostsController do

  describe "GET #new" do
    it "requires a logged-in user" do
      get :new
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe "POST #create" do
    it "requires a logged-in user" do
      post :create, post: { title: "Awesome title", body: "Awesome content" }
      expect(response).to redirect_to(new_user_session_path)
    end

    it "does not save a new record in database" do
      expect {post :create, post: attributes_for(:post) }.not_to change(Post, :count)
    end
  end

  context "when user is signed in" do
    before :each do
      login_user
    end

    it "allows the access to new page" do
      get:new
      expect(response).to render_template(:new)
    end

    it "allows user to create a post" do
      expect{post :create, post: attributes_for(:post) }.to change(Post, :count).by(1)
    end
  end
end

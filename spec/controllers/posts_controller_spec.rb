require "rails_helper"

RSpec.describe PostsController do

  describe "GET #show" do
    let(:post) { create(:post) }

    it "non-logged-in user can also access the page" do
      get :show, id: post.id
      expect(response).to render_template(:show)
    end
  end

  describe "GET #new" do
    it "requires a logged-in user" do
      get :new
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe "POST #create" do
    it "requires a logged-in user" do
      post :create, post: { title: "Awesome title", body: "Awesome content", commit: "Publish" }
      expect(response).to redirect_to(new_user_session_path)
    end

    it "does not save a new record in database" do
      expect {post :create, post: attributes_for(:post), commit: "Publish" }.not_to change(Post, :count)
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

    describe "POST #create" do
      it "allows user to create a post" do
        expect{post :create, post: attributes_for(:post), commit: "Publish" }.to change(Post, :count).by(1)
      end

      it "fails create gracefully" do
        new_post = Post.new
        expect(new_post).to receive(:save).and_return(false)
        allow(Post).to receive(:new).and_return(new_post)
        post :create, post: attributes_for(:post), commit: "Publish"
        expect(response).to render_template(:new)
      end
    end
  end

  context "when a user trying to edit, update, or delete other users post" do
    let(:user) { create(:user) }
    let(:other_user) { create(:user) }
    let!(:other_user_post) { create(:post, user: other_user) }

    before :each do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in user
    end

    it "does not allow user to edit post" do
      get :edit, id: other_user_post.id
      expect(response).to redirect_to(root_path)
    end

    it "does not allow user to update post" do
      patch :update, id: other_user_post.id, post: attributes_for(:post), commit: "Publish"
      expect(response).to redirect_to(root_path)
    end

    it "does not allow user to delete post" do
      expect { delete :destroy, id: other_user_post.id }.not_to change{ Post.count }
    end

  end
end

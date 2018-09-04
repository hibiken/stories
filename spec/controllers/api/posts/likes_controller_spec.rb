require "rails_helper"

RSpec.describe Api::Posts::LikesController do

  describe "Access Control" do
    before :each do
      @author = create(:user)
      @post = create(:post, user: @author)
    end

    describe "POST #create" do

      it "requires a logged-in user and responds with 401 Unauthorized" do
        post :create, params:{ post_id: @post.id}, xhr: true
        expect(response.status).to eq(401)
      end

      context "when user is logged in" do
        before :each do
          @user = create(:user)
          login @user
        end

        it "allows user to like a post" do
          post :create, params: {post_id: @post.id}, xhr: true
          expect(@user.liked?(@post)).to be_truthy
        end

        it "notifies the author" do
          expect{ post :create, params: {post_id: @post.id}, xhr: true }.
            to change(@author.notifications, :count).by(1)
        end
      end
    end

    describe "DELETE #destroy" do

      it "requires a logged-in user and responds with 401 Unauthorized" do
        delete :destroy, params: {post_id: @post.id}, xhr: true
        expect(response.status).to eq(401)
      end

      context "when user is logged in" do
        before :each do
          @user = create(:user)
          login @user
          @user.add_like_to(@post)
        end

        it "allows user to unlike a post" do
          delete :destroy, params: {post_id: @post.id}, xhr: true
          expect(@user.liked?(@post)).to be_falsy
        end

      end
    end
  end

end

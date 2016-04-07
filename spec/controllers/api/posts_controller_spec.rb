require "rails_helper"

RSpec.describe API::PostsController do

  describe "Access Control" do
    describe "PATCH #update" do
      let(:post) { create(:post) }

      it "requires a logged-in user" do
        xhr :patch, :update, id: post.id, post: { title: "Updated title", body: "Updated body" }
        expect(response.status).to eq(401)
      end

      it "doesn't let user update other users post and raise an error" do
        other_user = create(:user)
        others_post = create(:post, user: other_user)
        user = create(:user)
        @request.env["devise.mapping"] = Devise.mappings[:user]
        sign_in user

        expect{xhr :patch, :update, id: others_post.id, post: { title: "hello", body: "world" }}.
          to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  context "when user is logged-in" do
    before :each do
      @user = create(:user)
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in @user
    end

    describe "updating drafts" do
      before :each do
        draft = create(:draft, user: @user)
        xhr :patch, :update, id: draft.id, post: { title: "updated title", body: "updated body" }
        @updated_draft = assigns(:post)
      end

      it "saves a draft as a draft" do
        expect(@updated_draft).not_to be_published
      end

      it "updates the title and body" do
        expect(@updated_draft.title).to eq("updated title")
        expect(@updated_draft.body).to eq("updated body")
      end
    end

    describe "updating published posts" do
      before :each do
        published_post = create(:post, user: @user)
        xhr :patch, :update, id: published_post.id, post: { title: "updated title", body: "updated body" }
        @updated_post = assigns(:post)
      end

      it "saves the post as a published post" do
        expect(@updated_post).to be_published
      end

      it "updates the title and body" do
        expect(@updated_post.title).to eq("updated title")
        expect(@updated_post.body).to eq("updated body")
      end
    end

  end
end

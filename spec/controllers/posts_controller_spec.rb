require "rails_helper"

RSpec.describe PostsController do

  describe "Access Control" do
    describe "GET #show" do
      let(:post) { create(:post) }

      it "non-logged-in user can also access the page" do
        get :show, id: post.slug
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
        post :create, post: { title: "Awesome title", body: "Awesome content" }
        expect(response).to redirect_to(new_user_session_path)
      end

      it "does not save a new record in database" do
        expect {post :create, post: attributes_for(:post)}.not_to change(Post, :count)
      end
    end

    describe "POST #create_and_edit" do
      it "requires a logged-in user" do
        post :create_and_edit, post: { title: "", body: "Cool content" }
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe "PATCH #update" do
      let(:post) { create(:post) }
      it "requires a logged-in user" do
        patch :update, id: post.id, post: { title: "Updated title", body: "Updated body" }
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe "DELETE #destroy" do
      let(:post) { create(:post) }
      it "requires a logged-in user" do
        delete :destroy, id: post.id
        expect(response).to redirect_to(new_user_session_path)
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
        patch :update, id: other_user_post.id, post: attributes_for(:post)
        expect(response).to redirect_to(root_path)
      end

      it "does not allow user to delete post" do
        expect { delete :destroy, id: other_user_post.id }.not_to change{ Post.count }
      end
    end
  end

  describe "Happy Path" do
    context "when user is signed in" do
      before :each do
        login_user
      end

      it "allows the access to new page" do
        get :new
        expect(response).to render_template(:new)
      end

      describe "POST #create" do
        it "allows user to create a post" do
          expect{post :create, post: attributes_for(:post)}.to change(Post, :count).by(1)
        end
      end

      describe "POST #create_and_edit" do
        it "creates a post and redirect_to edit page" do
          @draft = build(:draft, title: "   ", body: "this is a story of my life")
          expect{post :create_and_edit, post: { title: @draft.title, body: @draft.body } }.to change(Post, :count).by(1)
        end

        it "redirects to edit page" do
          @draft = build(:draft, title: "", body: "hello world")
          post :create_and_edit, post: { title: @draft.title, body: @draft.body }
          expect(response).to redirect_to(edit_post_path(assigns(:post)))
        end
      end
    end
  end

  describe "Unhappy Path" do
    before :each do
      @user = create(:user)
      sign_in @user
    end

    describe "POST #create" do
      it "fails gracefully when it fails validations" do
        post :create, post: attributes_for(:draft, title: "  ")
        expect(response).to render_template(:new)
      end
    end

    describe "PATCH #update" do
      before :each do
        @draft = Post.new_draft_for(@user)
      end

      it "fails gracefully when it fails validations" do
        patch :update, id: @draft.id, post: attributes_for(:draft, body: "   ")
        expect(response).to render_template(:edit)
      end
    end
  end

end

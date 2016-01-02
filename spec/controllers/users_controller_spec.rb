require "rails_helper"

RSpec.describe UsersController do
  context "when not logged in" do
    let(:user) { create(:user) }

    describe "GET #edit" do
      it "redirects to sign in page" do
        get :edit, id: user.id
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe "PATHCH #update" do
      it "does not update the record and redirects to sign in page" do
        patch :update, id: user.id, user: { username: 'exampleuser', 
                                            description: 'some desc' }
        user.reload
        expect(user.description).not_to eq('some desc')
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  context "when logged in and trying to access other account" do
    let(:user) { create(:user) }
    let(:other_user) { create(:user) }
    before :each do
      sign_in user
    end

    describe "GET #edit" do
      it "restrict access to other users' profile edit page" do
        get :edit, id: other_user.id
        expect(response).to redirect_to(root_path)
      end
    end

    describe "PATCH #update" do
      it "does not update the record and redirects to sign in page" do
        patch :update, id: other_user.id, user: { username: "updatedname",
                                                  description: "some desc" }
        user.reload
        expect(user.description).not_to eq("some desc")
        expect(response).to redirect_to(root_path)
      end
    end
  end
end

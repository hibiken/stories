# require "rails_helper"

# feature "Editing profile" do
#   let(:user) { create(:user) }
#   let(:other_user) { create(:user) }
#   before :each do
#     sign_in user
#   end

#   scenario "current user successfully edit his/her own" do
#     visit edit_user_path(user)
#     fill_in "user[username]", with: "New Username"
#     fill_in "user[description]", with: "Awesome Developer"
#     click_on "Save Change"

#     expect(page).to have_content "New Username"
#     expect(page).to have_content "Awesome Developer"
#   end

#   scenario "user cannot go to other users' profile edit page" do
#     visit user_path(other_user)
#     expect(page).not_to have_link "Edit"
#   end
# end

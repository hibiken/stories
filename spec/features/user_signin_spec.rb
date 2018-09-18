# require "rails_helper"

# feature "User signs in" do
#   scenario "successfully" do
#     user = create(:user, username: 'exampleuser')
#     sign_in user
#     expect(page).to have_content 'Sign out'
#     expect(current_path).to eq(root_path)
#   end

#   scenario "admin user cannot go to log in page" do
#     admin = Admin.create!(email: "admin@email.com", password: "password")
#     # Log in as an Admin first.
#     visit new_admin_session_path
#     fill_in "Email", with: admin.email
#     fill_in "Password", with: admin.password
#     click_on "Log in"

#     visit new_user_session_path
#     expect(current_path).to eq(admin_dashboard_path)
#     expect(page).to have_content "Please sign out of admin session"
#   end
# end

# require "rails_helper"

# RSpec.feature "Admin signing in" do
#   let(:admin) { Admin.create!(email: "admin@example.com", password: "password") }
#   let(:user) { create(:user) }

#   scenario "admin user signs in and see Admin dashboard page and signs out successfully" do
#     visit new_admin_session_path
#     fill_in "Email", with: admin.email
#     fill_in "Password", with: admin.password
#     click_on "Log in"

#     expect(current_path).to eq(admin_dashboard_path)

#     expect(page).to have_link "Sign out"
#     click_on "Sign out"

#     expect(current_path).to eq(root_path)

#     visit admin_dashboard_path
#     expect(current_path).to eq(new_admin_session_path)
#   end

#   scenario "user cannot go to admin sign in page if he/she is logged in as a normal user" do
#     sign_in user
#     visit new_admin_session_path
#     expect(current_path).to eq(root_path)
#     expect(page).to have_content "Please sign out first"
#   end
# end

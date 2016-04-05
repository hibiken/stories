# require "rails_helper"

# RSpec.feature "adding/removing featured tag" do
#   let(:admin) { Admin.create!(email: "admin@email.com", password: "password") }
#   let(:music_tag) { Tag.create!(name: "Music") }
#   let(:food_tag) { Tag.create!(name: "Food") }

#   scenario "admin can add and remove featured tag" do
#     visit new_admin_session_path
#     fill_in "Email", with: admin.email
#     fill_in "Password", with: admin.password
#     click_on "Log in"

#     visit tag_path(music_tag)
#     click_on "Feature"

#     visit admin_dashboard_path
#     within(".featured-tags") do
#       expect(page).to have_link "Music"
#     end

#     visit tag_path(music_tag)
#     click_on "Unfeature"

#     visit admin_dashboard_path
#     within(".featured-tags") do
#       expect(page).not_to have_link "Music"
#     end
#   end
# end

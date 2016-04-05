require "rails_helper"

# RSpec.feature "Add a response to a post" do
#   let(:user) { create(:user, username: "Example User") }
#   let(:author) { create(:user, username: "Author of post") }
#   let(:post) { create(:post, user: author) }

#   scenario "signed in user successfully adds a response" do
#     sign_in user
#     visit post_path(post)
#     fill_in "response[body]", with: "Great post. Thanks!"
#     click_on "Publish"

#     expect(current_path).to eq(post_path(post))
#     expect(page).to have_content("Great post. Thanks!")
#   end

#   scenario "non-logged in user cannot create a response" do
#     visit post_path(post)
#     expect(current_path).to eq(post_path(post))
#     fill_in "response[body]", with: "Great post!"
#     click_on "Publish"

#     expect(current_path).to eq(new_user_session_path)
#   end

#   scenario "creates a notification for author of the post", js: true do
#     login_as(user, scope: :user) # Warden::Test::Helpers
#     visit post_path(post)
#     fill_in "response[body]", with: "Great post!"
#     click_on "Publish"
#     logout(:user)

#     sign_in author

#     # See new notification
#     within("#notifications") do
#       expect(page).to have_content("1")
#       click_on "1"
#       within("#notification-items") do
#         expect(page).to have_content "Example User responded to your post"
#       end
#     end
#   end
# end

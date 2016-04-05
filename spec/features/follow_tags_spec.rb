# require "rails_helper"

# RSpec.feature "Following tags" do
#   let(:user) { create(:user) }
#   let(:post) { create(:post) }
#   let(:music_tag) { Tag.create(name: "Music") }
#   background do
#     sign_in user
#     post.tags << music_tag
#   end

#   scenario "signed in user follows a tag successfully", js: true do
#     visit post_path(post)
#     within(".post-tags") do
#       click_on "Music"
#     end
#     expect(current_path).to eq(tag_path(music_tag))
#     expect(page).to have_css ".follow-button"
#     expect(page).not_to have_css ".unfollow-button"

#     click_on "Follow"
#     expect(page).to have_css ".unfollow-button"
#     expect(page).not_to have_css ".follow-button"

#     visit root_path
#     within(".following-tag-list") do
#       expect(page).to have_content "Music"
#       click_on "Music"
#     end

#     expect(current_path).to eq(tag_path(music_tag))
#     click_on "Unfollow"

#     visit root_path
#     within(".following-tag-list") do
#       expect(page).not_to have_content "Music"
#     end
#   end
# end

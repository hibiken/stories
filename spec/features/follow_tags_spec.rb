require "rails_helper"

RSpec.feature "Following tags" do
  let(:user) { create(:user) }
  let(:post) { create(:post) }
  let(:music_tag) { Tag.create(name: "Music") }
  background do
    sign_in user
    post.tags << music_tag
  end

  scenario "signed in user follows a tag successfully" do
    visit post_path(post)
    within(".post-tags") do
      click_on "Music"
    end
    expect(current_path).to eq(tag_path(music_tag))
    expect(page).to have_button "Follow"
    expect(page).not_to have_button "Unfollow"

    click_on "Follow"
    expect(page).to have_button "Unfollow"
    expect(page).not_to have_button "Follow"

    visit dashboard_path
    within(".following-tags") do
      expect(page).to have_content "Music"
    end
  end
end

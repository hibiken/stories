require "rails_helper"

RSpec.feature "Bookmarking a post" do
  let(:user) { create(:user) }
  let(:post) { create(:post) }

  scenario "signed-in user bookmarks a post successfully", js: true do
    sign_in user
    visit post_path(post)
    click_on "Bookmark"
    expect(current_path).to eq(post_path(post))
    expect(page).to have_button "Unbookmark"

    click_on "Unbookmark"
    expect(current_path).to eq(post_path(post))
    expect(page).to have_button "Bookmark"
  end

  scenario "non-logged in user cannot bookmark a post", js: true do
    visit post_path(post)
    click_on "Bookmark"
    expect(page).to have_content("Sign in with Facebook")
  end
end

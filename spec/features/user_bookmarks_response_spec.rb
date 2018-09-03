require "rails_helper"

RSpec.feature "Bookmarking a response" do
  let(:user) { create(:user) }
  let(:post) { create(:post) }
  let(:response) { build(:response) }

  background do
    post.responses << response
  end

  scenario "signed-in user bookmarks a response", js: true do
    sign_in user
    visit post_path(post, anchor: "responses")
    within("#responses") do
      click_on "Bookmark"
      expect(page).to have_button "Unbookmark"

      click_on "Unbookmark"
      expect(page).to have_button "Bookmark"
    end
  end

  scenario "non-logged in user cannot bookmark a response", js: true do
    visit post_path(post)
    within("#responses") do
      click_on "Bookmark"
    end

    expect(page).to have_content("Sign in with Facebook")
  end
end

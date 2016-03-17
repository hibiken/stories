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
    visit post_path(post)
    within(".response") do
      click_on "Bookmark"
    end

    expect(current_path).to eq(post_path(post))
    within(".response") do
      expect(page).to have_button "Unbookmark"
      click_on "Unbookmark"
    end

    expect(current_path).to eq(post_path(post))
    within(".response") do
      expect(page).to have_button "Bookmark"
    end
  end

  scenario "non-logged in user cannot bookmark a response", js: true do
    visit post_path(post)
    within(".response") do
      click_on "Bookmark"
    end

    expect(current_path).to eq(new_user_session_path)
  end
end

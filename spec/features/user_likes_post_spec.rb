require "rails_helper"

RSpec.feature "Liking a post" do
  let(:user) { create(:user, username: "Example User") }
  let(:author) { create(:user, username: "Author of post") }
  let(:post) { create(:post, user: author) }

  scenario "signed-in user likes a post successfully", js: true do
    sign_in user
    visit post_path(post)
    within("#main-post") do
      click_on "Like"
      expect(page).to have_button "Unlike"
      expect(page).not_to have_button "Like"
    end

    within("#main-post") do
      click_on "Unlike"
      expect(page).to have_button "Like"
      expect(page).not_to have_button "Unlike"
    end
  end

  scenario "non-logged in user cannot like a post", js: true do
    visit post_path(post)
    within("#main-post") do
      click_on "Like"
    end
    expect(page).to have_content("Sign in with Facebook")
  end

end

require "rails_helper"

RSpec.feature "Liking a response" do
  let(:user) { create(:user) }
  let(:post) { create(:post) }
  let(:response) { build(:response) }

  background do
    post.responses << response
  end

  scenario "signed-in user likes a response", js: true do
    sign_in user
    visit post_path(post, anchor: "responses")
    within("#responses") do
      click_on "Like"
      expect(page).to have_button "Unlike"

      click_on "Unlike"
      expect(page).to have_button "Like"
    end
  end

  scenario "non-logged in user cannot like a response", js: true do
    visit post_path(post)
    within("#responses") do
      click_on "Like"
    end

    expect(page).to have_content("Sign in with Facebook")
  end
end

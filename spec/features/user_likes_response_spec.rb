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
    visit post_path(post)
    within(".response") do
      click_on "Like"
    end

    expect(current_path).to eq(post_path(post))
    within(".response") do
      expect(page).to have_button "Unlike"
      click_on "Unlike"
    end

    expect(current_path).to eq(post_path(post))
    within(".response") do
      expect(page).to have_button "Like"
    end
  end

  scenario "non-logged in user cannot like a response", js: true do
    visit post_path(post)
    within(".response") do
      click_on "Like"
    end

    expect(current_path).to eq(new_user_session_path)
  end
end

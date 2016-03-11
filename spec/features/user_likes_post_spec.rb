require "rails_helper"

RSpec.feature "Liking a post" do
  let(:user) { create(:user, username: "Example User") }
  let(:author) { create(:user, username: "Author of post") }
  let(:post) { create(:post, user: author) }

  scenario "signed-in user likes a post successfully", js: true do
    sign_in user
    visit post_path(post)
    click_on "Like"
    expect(current_path).to eq(post_path(post))
    expect(page).to have_button "Unlike"
    expect(page).not_to have_button "Like"

    click_on "Unlike"
    expect(current_path).to eq(post_path(post))
    expect(page).to have_button "Like"
    expect(page).not_to have_button "Unlike"
  end

  scenario "non-logged in user cannot like a post", js: true do
    visit post_path(post)
    click_on "Like"

    expect(page).to have_content("Sign in with Facebook")
  end

  scenario "creates a notification for author of the post", js: true do
    login_as(user, scope: :user) # Warden::Test::Helpers
    visit post_path(post)
    expect(page).to have_css "#notifications"
    click_on "Like"

    logout(:user)

    sign_in author

    # See new notification
    within("#notifications") do
      expect(page).to have_content("1")
      click_on "1"
      within("#notification-items") do
        expect(page).to have_content "Example User liked your post"
      end
    end

    # New notification is cleared
    within("#notifications") do
      expect(page).not_to have_content("1")
    end
  end
end

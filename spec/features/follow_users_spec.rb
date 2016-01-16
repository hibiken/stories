require "rails_helper"

RSpec.feature "Signed in User follow other users" do
  let(:user) { create(:user, username: "Example User") }
  let(:other_user) { create(:user) }

  scenario "by navigating to other user's profile page and click on follow button" do
    sign_in user
    visit user_path(other_user)
    expect(page).to have_css ".follow-button"
    expect(page).not_to have_css ".unfollow-button"

    click_on "Follow"
    expect(page).to have_css ".unfollow-button"
    expect(page).not_to have_css ".follow-button"
    expect(page).to have_content "1 Follower"
    click_on "Unfollow"
    expect(page).to have_css ".follow-button"
    expect(page).not_to have_css ".unfollow-button"
  end

  scenario "creates a notification for followed user", js: true do
    login_as(user, scope: :user) # Warden::Test::Helpers
    visit user_path(other_user)
    click_on "Follow"
    logout(:user)

    sign_in other_user

    # See new notification
    within("#notifications") do
      expect(page).to have_content("1")
      click_on "1"
      within("#notification-items") do
        expect(page).to have_content "Example User started following you"
      end
    end

  end
end

require "rails_helper"

RSpec.feature "Signed in User follow other users" do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }

  background do
    sign_in user
  end

  scenario "by navigating to other user's profile page and click on follow button" do
    visit user_path(other_user)
    expect(page).to have_button "Follow"
    expect(page).not_to have_button "Unfollow"

    click_on "Follow"
    expect(page).to have_button "Unfollow"
    expect(page).not_to have_button "Follow"
    expect(page).to have_content "1 Follower"
    click_on "Unfollow"
    expect(page).to have_button "Follow"
    expect(page).not_to have_button "Unfollow"
  end
end

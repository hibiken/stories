require "rails_helper"

RSpec.feature "Signed in User follow other users" do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }

  background do
    sign_in user
  end

  scenario "by navigating to other user's profile page and click on follow button" do
    visit user_path(other_user)
    expect(page).to have_link "Follow"
    expect(page).not_to have_link "Following"

    click_on "Follow"
    expect(page).to have_link "Following"
    expect(page).not_to have_link "Follow"
    expect(page).to have_content "1 Follower"
  end
end

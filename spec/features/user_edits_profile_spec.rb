require "rails_helper"

feature "User edits profile" do
  let(:user) { create(:user) }

  scenario "successfully" do
    visit edit_user_path(user)
    fill_in "Username", with: "New Username"
    fill_in "Description", with: "Awesome Developer"
    click_on "Save"

    expect(page).to have_content "New Username"
    expect(page).to have_content "Awesome Developer"
  end
end

require "rails_helper"

feature "User creates post" do
  scenario "requires the user to log in" do
    visit root_path
    click_on "Write story"

    expect(current_path).to eq(new_user_session_path)
  end

  scenario "successfully" do
    sign_in_a_user
    visit root_path
    click_on "Write story"
    fill_in "Title", with: "My awesome Article"
    fill_in "Body", with: "some awesome content..."
    click_on "Publish"

    visit root_path
    expect(page).to have_content "My awesome Article"
  end
end

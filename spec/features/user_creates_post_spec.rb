require "rails_helper"

feature "User creates post" do
  scenario "successfully" do
    visit root_path
    click_on "New Post"
    fill_in "Title", with: "My awesome Article"
    fill_in "Body", with: "some awesome content..."
    click_on "Publish"

    visit posts_path
    expect(page).to have_content "My awesome Article"
  end
end

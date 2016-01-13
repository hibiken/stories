require "rails_helper"

feature "User creates post" do
  scenario "requires the user to log in" do
    visit root_path
    click_on "Write a story"

    expect(current_path).to eq(new_user_session_path)
  end

  scenario "successfully and edits the post" do
    sign_in_a_user
    visit root_path
    click_on "Write a story"
    fill_in "post[title]", with: "My awesome Article"
    fill_in "post[body]", with: "some awesome content..."
    fill_in "post[all_tags]", with: "travel, fun, life"
    click_on "Publish"

    visit root_path
    expect(page).to have_content "My awesome Article"

    within(".dashboard-main-content") do
      click_on "My awesome Article"
    end
    expect(page).to have_link "Edit"
    expect(page).to have_link "Delete"
    click_on "Edit"

    fill_in "Title", with: "Updated Title"
    click_on "Publish"

    visit root_path
    within(".dashboard-main-content") do
      click_on "Updated Title"
    end
    click_on "Delete"

    expect(current_path).to eq(root_path)
    expect(page).not_to have_content "Updated Title"
  end
end

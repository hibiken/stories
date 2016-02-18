require "rails_helper"

RSpec.feature "Viewing drafts" do
  scenario "successfully" do
    sign_in_a_user
    click_on "Write a story"
    fill_in "post[title]",    with: "My first Article"
    fill_in "post[body]",     with: "some cool content"
    fill_in "post[all_tags]", with: "travel, fun, life"
    click_on "Save as Draft"

    visit stories_drafts_path
    expect(page).to have_content "My first Article"

    visit root_path
    expect(page).not_to have_content "My first Article"
  end
end

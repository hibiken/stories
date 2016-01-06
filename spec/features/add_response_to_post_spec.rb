require "rails_helper"

RSpec.feature "Add a response to a post" do
  let(:user) { create(:user) }
  let(:post) { create(:post) }

  scenario "signed in user successfully adds a response" do
    sign_in user
    visit post_path(post)
    fill_in "response[body]", with: "Great post. Thanks!"
    click_on "Publish"

    expect(current_path).to eq(post_path(post))
    expect(page).to have_content("Great post. Thanks!")
  end

  scenario "non-logged in user cannot create a response" do
    visit post_path(post)
    expect(current_path).to eq(post_path(post))
    fill_in "response[body]", with: "Great post!"
    click_on "Publish"

    expect(current_path).to eq(new_user_session_path)
  end
end

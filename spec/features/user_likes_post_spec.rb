require "rails_helper"

RSpec.feature "Liking a post" do
  let(:user) { create(:user) }
  let(:post) { create(:post) }

  scenario "signed-in user likes a post successfully", js: true do
    sign_in user
    visit post_path(post)
    click_on "Like"
    expect(current_path).to eq(post_path(post))
    expect(page).to have_button "Unlike"

    click_on "Unlike"
    expect(current_path).to eq(post_path(post))
    expect(page).to have_button "Like"
  end
end

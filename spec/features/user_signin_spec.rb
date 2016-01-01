require "rails_helper"

feature "User signs in" do
  scenario "successfully" do
    user = create(:user, username: 'exampleuser')
    sign_in user
    expect(page).to have_content user.username
    expect(current_path).to eq(dashboard_path)
  end
end

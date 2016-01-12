require "rails_helper"

RSpec.feature "Admin signing in" do
  let(:admin) { Admin.create!(email: "admin@example.com", password: "password") }

  scenario "admin user signs in and see Admin dashboard page and signs out successfully" do
    visit new_admin_session_path
    fill_in "Email", with: admin.email
    fill_in "Password", with: admin.password
    click_on "Log in"

    expect(current_path).to eq(admin_dashboard_path)

    expect(page).to have_link "Sign out"
    click_on "Sign out"

    expect(current_path).to eq(root_path)

    visit admin_dashboard_path
    expect(current_path).to eq(new_admin_session_path)
  end
end

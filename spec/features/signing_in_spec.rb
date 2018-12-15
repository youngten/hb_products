require "rails_helper"
RSpec.feature "Users can sign in" do
  let!(:user) { FactoryGirl.create(:user) }
  scenario "with valid credentials" do
    visit "/"
    click_link "登入"
    fill_in "Email", with: user.email
    fill_in "Password", with: "password"
    click_button "Log in"
    expect(page).to have_content "Signed in successfully."
  end
end
require "rails_helper"
RSpec.feature "Signed-in users can sign out" do
  let!(:user) { FactoryGirl.create(:user) }
  before do
    visit "/"
    click_link "登入"
    fill_in "Email", with: user.email
    fill_in "Password", with: "password"
    click_button "Log in"
  end
  scenario do
    visit "/"
    click_link "登出"
    expect(page).to have_content "Signed out successfully."
  end
end
require "rails_helper"
RSpec.feature "Users can view products" do
  scenario "with the product details" do
    product = FactoryGirl.create(:product, name: "Sublime Text 3", price: 12, image: 'iphone.jpg', user_id: 1)
    visit "/"
    click_link "Show"
    expect(page.current_url).to eq product_url(product)
  end
end
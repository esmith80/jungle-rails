require 'rails_helper'

RSpec.feature "Visitor navigates to a Product Details page", type: :feature, js: true do
  
  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "correct product detail page is displayed after clicking product partial" do
    # ACT
    visit root_path
    
    first('article.product').find_link('Details').click

    # DEBUG
    save_and_open_screenshot
    puts page.html

    # VERIFY
    expect(page).to have_css 'article.product-detail', count: 1
    expect(page).to have_content('Quantity')
  end
end

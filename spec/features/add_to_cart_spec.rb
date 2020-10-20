require 'rails_helper'

RSpec.feature "Add to Cart", type: :feature, js: true do
  
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

  scenario "clicking the 'Add to Cart' button increases their cart by one" do
    # ACT
    visit root_path    
    expect(page).to have_content('My Cart (0)')
    
    first('button').click
    # DEBUG
    # save_and_open_screenshot

    # VERIFY
    expect(page).to have_content('My Cart (1)')
  end
end

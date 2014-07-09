require 'rails_helper'




feature 'user makes a search' do
  background do
  end
  scenario 'searches for harry potter' do
    visit root_path
    fill_in 'Search', with: 'Harry Potter'
    click_button 'Search'


    expect(page).to have_css '.book', text: 'Harry Potter'
    expect(page).to have_css '.book', text: 'J.K. Rowling'

  end
end

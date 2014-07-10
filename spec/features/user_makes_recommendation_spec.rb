require 'rails_helper'

feature 'user makes a recommndation to another user' do
  background do
    @usr_a = create(:user)
    @usr_b = create(:user, username: 'usrb', email: 'usrb@example.com')
    Follow.create(user: @usr_a, followee: @usr_b)
    Follow.create(user: @usr_b, followee: @usr_a)

    visit root_path
    sign_in_as(@usr_a)
    add_book
  end

  scenario 'and the other user sees it.' do
    click_link @usr_a.username
    click_link 'ToRead'
    click_link 'Recommend to:'
    click_link @usr_b.username
    click_link @usr_a.username
    click_link 'Logout'
    sign_in_as(@usr_b)
    click_link @usr_b.username
    click_link 'messages'
    expect(page).to have_content @usr_a.username
  end
end

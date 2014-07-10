module SessionHelpers
  def sign_in_as(user)
    visit root_path
    click_link 'Profile'
    click_link 'Login'
    fill_in 'Login', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign in'
  end

  def add_book
    visit root_path
    fill_in "Search", with: "Harry Potter"
    click_button 'Search'
    within(".book", text: "Harry Potter and the Sorcerer's Stone") do
      click_button 'Add to MyReads'
    end
  end
end

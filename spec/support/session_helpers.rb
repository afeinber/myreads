module SessionHelpers
  def sign_in_as(user)
    visit root_path
    click_link 'Profile'
    click_link 'Login'
    fill_in 'Login', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign in'
  end
end

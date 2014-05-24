module CapybaraHelpers

  def sign_up_user
    visit '/'
    click_on 'Sign up'
    fill_in 'Email', with: 'bob@example.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    click_button 'Sign up'
  end

  def sign_in_user
    visit '/'
    click_on 'Sign in'
    fill_in 'Email', with: 'bob@example.com'
    fill_in 'Password', with: 'password'
    click_button 'Sign in'
  end

end
require 'rails_helper'

feature 'sign out' do
  include SignInHelpers

  it 'allows a user to sign out' do
    admin = create(:admin)
    sign_in_with_admin(admin)
    visit root_path

    click_on 'Sign out'

    expect(page).to have_current_path(root_path)
    expect(page).to_not have_content('Sign out')
  end
end

require 'rails_helper'

feature 'sign in' do
  include SignInHelpers

  scenario 'signing in as an unauthorized user redirects to root with error' do
    sign_in_with_email('not-an-admin@example.com')

    expect(page).to have_current_path(root_path)
    expect(page).to have_content('You are not authorized to access the admin console')
  end

  scenario 'signing in as an authorized user redirects to root with options' do
    admin = create(:admin)
    sign_in_with_admin(admin)

    expect(page).to have_current_path(root_path)
    expect(page).to have_content('User lookup')
    expect(page).to have_content('Blazer')
  end
end

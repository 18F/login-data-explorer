require 'rails_helper'

feature 'accessing blazer' do
  include SignInHelpers

  context 'without signing in' do
    it 'does not allow access' do
      visit blazer_path

      expect(page).to have_current_path(root_path)
      expect(page).to have_content('You need to sign in or sign up before continuing.')
    end
  end

  context 'signing in as a non-authorized user' do
    it 'does not allow access' do
      admin = create(:admin, email: 'the-admin@example.com')

      sign_in_with_email('not-the-admin@example.com')
      visit blazer_path

      expect(page).to have_current_path(root_path)
      expect(page).to have_content('You need to sign in or sign up before continuing.')
    end
  end

  context 'signing in as an admin' do
    it 'does not allow access' do
      admin = create(:admin, email: 'the-admin@example.com')

      sign_in_with_email('the-admin@example.com')
      visit blazer_path

      expect(page).to have_current_path(blazer_path)
    end
  end
end

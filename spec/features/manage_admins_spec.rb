require 'rails_helper'

feature 'manage admins' do
  include SignInHelpers

  scenario 'inviting an admin' do
    admin = create(:admin)

    sign_in_with_admin(admin)
    visit admins_path
    click_on 'New admin'
    fill_in :create_admin_form_email, with: 'invited@gmail.com'
    click_on 'Create'

    expect(page).to have_current_path(admins_path)
    expect(page).to have_content('Admin created')
    expect(page).to have_content('invited@gmail.com')
  end

  scenario 'inviting an admin that already exists' do
    admin = create(:admin)
    invited_admin = create(:admin, email: 'invited@gmail.com')

    sign_in_with_admin(admin)
    visit admins_path
    click_on 'New admin'
    fill_in :create_admin_form_email, with: 'invited@gmail.com'
    click_on 'Create'

    expect(page).to have_current_path(admins_path)
    expect(page).to have_content('Email already taken')
  end

  scenario 'deleting an admin' do
    admin = create(:admin, created_at: 1.day.ago)
    invited_admin = create(:admin, email: 'invited@gmail.com')

    sign_in_with_admin(admin)
    visit admins_path

    row = page.all('tr', text: 'invited@gmail.com').first
    row.find_button('Delete').click

    expect(page).to have_current_path(admins_path)
    expect(page).to have_content('Admin deleted successfully')
    expect(Admin.where(email: 'invited@gmail.com')).to_not exist
  end
end

require 'rails_helper'

describe 'User lookup' do
  include SignInHelpers

  scenario 'looking up a user and seeing their email addresses and phone numbers' do
    user = create(:idp_user, email: 'confirmed@gmail.com')
    create(:idp_email_address, email: 'unconfirmed@gmail.com', user: user, confirmed_at: nil)
    create(:idp_phone_configuration, phone: '+1 111 111-1000', user: user, confirmed_at: nil)
    create(:idp_phone_configuration, phone: '+1 222 222-2000', user: user, mfa_enabled: false)
    create(:idp_webauthn_configuration, name: 'Web token', user: user)

    admin = create(:admin)
    sign_in_with_admin(admin)

    visit user_lookup_path

    fill_in :user_lookup_form_email, with: 'confirmed@gmail.com'
    click_on 'Submit'

    expect(page).to have_content('confirmed@gmail.com Confirmed')
    expect(page).to have_content('unconfirmed@gmail.com Not confirmed')
    expect(page).to have_content('+1 111 111-1000 Not confirmed Enabled')
    expect(page).to have_content('+1 222 222-2000 Confirmed Not enabled')
    expect(page).to have_content('Web token')
    expect(page).to have_content("TOTP:\nNot enabled")
    expect(page).to have_content("PIV/CAC:\nNot enabled")
  end

  scenario 'looking up a user that does not exist' do
    admin = create(:admin)
    sign_in_with_admin(admin)

    visit user_lookup_path

    fill_in :user_lookup_form_email, with: 'dne@gmail.com'
    click_on 'Submit'

    expect(page).to have_content('Unable to find a user with email dne@gmail.com')
  end
end

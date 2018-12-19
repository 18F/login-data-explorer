module SignInHelpers
  def sign_in_with_email(email, uuid: '1234-5678-adsf-qerty')
    OmniAuth.config.add_mock(
      :logindotgov,
      uid: uuid,
      info: {
        email: email,
        uuid: uuid,
      }
    )
    visit auth_logindotgov_callback_url
  end

  def sign_in_with_admin(admin)
    sign_in_with_email(admin.email, uuid: admin.uuid)
  end
end

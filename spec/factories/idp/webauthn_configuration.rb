FactoryBot.define do
  factory(:idp_webauthn_configuration, class: Idp::WebauthnConfiguration) do
    user { build(:idp_user) }
    name { 'My blue key thing' }
    credential_id { SecureRandom.uuid }
    credential_public_key { SecureRandom.urlsafe_base64 }
  end
end

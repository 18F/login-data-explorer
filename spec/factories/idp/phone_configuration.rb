FactoryBot.define do
  factory(:idp_phone_configuration, class: Idp::PhoneConfiguration) do
    user { build(:idp_user) }
    confirmed_at { 1.day.ago }
    mfa_enabled { true }

    transient do
      phone { '+1 555 555-5000' }
    end

    after(:build) do |phone_configuration, evaluator|
      phone = evaluator.phone
      encrypted_phone = Idp::AttributeEncryptor.new.encrypt(phone)

      phone_configuration.encrypted_phone = encrypted_phone
    end
  end
end

FactoryBot.define do
  factory(:idp_email_address, class: Idp::EmailAddress) do
    user { build(:idp_user) }
    confirmed_at { 1.day.ago }

    transient do
      email { Faker::Internet.safe_email }
    end

    after(:build) do |email_address, evaluator|
      email = evaluator.email
      encrypted_email = Idp::AttributeEncryptor.new.encrypt(email)
      email_fingerprint = Idp::Fingerprinter.fingerprint(email)

      email_address.encrypted_email = encrypted_email
      email_address.email_fingerprint = email_fingerprint
    end
  end
end

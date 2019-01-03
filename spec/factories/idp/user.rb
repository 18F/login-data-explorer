FactoryBot.define do
  factory(:idp_user, class: Idp::User) do
    transient do
      email { Faker::Internet.safe_email }
    end

    uuid { SecureRandom.uuid }

    after(:build) do |user, evaluator|
      email = evaluator.email
      encrypted_email = Idp::AttributeEncryptor.new.encrypt(email)
      email_fingerprint = Idp::Fingerprinter.fingerprint(email)

      user.encrypted_email = encrypted_email
      user.email_fingerprint = email_fingerprint
    end

    after(:create) do |user, _evaluator|
      create(
        :idp_email_address,
        user: user,
        email: _evaluator.email
      )
    end
  end
end

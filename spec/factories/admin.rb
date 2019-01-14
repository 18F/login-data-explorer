FactoryBot.define do
  factory :admin do
    email { Faker::Internet.safe_email }
    uuid { '1234-5678-asdf-qwerty' }
  end
end

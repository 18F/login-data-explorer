FactoryBot.define do
  factory(:idp_event, class: Idp::Event) do
    user { build(:idp_user) }
    created_at { Time.zone.now }
    event_type { 'account_created' }
  end
end

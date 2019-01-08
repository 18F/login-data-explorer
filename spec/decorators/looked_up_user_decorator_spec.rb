require 'rails_helper'

describe LookedUpUserDecorator do
  let(:user) { build(:idp_user) }

  subject { described_class.new(user) }

  describe '#piv_cac_enabled?' do
    context 'when the user has a x509 dn uuid' do
      let(:user) { build(:idp_user, x509_dn_uuid: SecureRandom.uuid) }

      it { expect(subject.piv_cac_enabled?).to eq(true) }
    end

    context 'when the user does not have an x509 dn uuid' do
      it { expect(subject.piv_cac_enabled?).to eq(false) }
    end
  end

  describe '#totp_enabled?' do
    context 'when the user has an otp secret' do
      let(:user) { build(:idp_user, encrypted_otp_secret_key: '123abc') }

      it { expect(subject.totp_enabled?).to eq(true) }
    end

    context 'when the user does not have an otp secret' do
      it { expect(subject.totp_enabled?).to eq(false) }
    end
  end

  describe '#recent_events' do
    it 'shows the most recent 50 events' do
      create_list(:idp_event, 25, user: user, created_at: DateTime.new(2019, 01, 03))
      create_list(:idp_event, 25, user: user, created_at: DateTime.new(2019, 01, 02))
      create_list(:idp_event, 25, user: user, created_at: DateTime.new(2019, 01, 01))

      events = subject.recent_events

      expect(events.length).to eq(50)
      expect(events.first.created_at).to eq(DateTime.new(2019, 01, 03))
      expect(events.last.created_at).to eq(DateTime.new(2019, 01, 02))
    end
  end
end

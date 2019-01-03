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
end

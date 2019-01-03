require 'rails_helper'

describe Idp::PhoneConfiguration do
  let(:phone) { '+1 555 555-5000' }
  let(:confirmed_at) { nil }

  subject do
    encrypted_phone = Idp::AttributeEncryptor.new.encrypt(phone)
    described_class.new(
      encrypted_phone: encrypted_phone,
      confirmed_at: confirmed_at
    )
  end

  describe '#phone' do
    it 'returns the decrypted phone' do
      expect(subject.phone).to eq(phone)
    end
  end

  describe '#confirmed?' do
    context 'when the phone has been confirmed' do
      let(:confirmed_at) { 1.day.ago }

      it { expect(subject.confirmed?).to eq(true) }
    end

    context 'when the phone has not been confirmed' do
      it { expect(subject.confirmed?).to eq(false) }
    end
  end
end

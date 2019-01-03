require 'rails_helper'

describe Idp::EmailAddress do
  let(:email) { 'asdf@gmail.com' }
  let(:confirmed_at) { nil }

  subject do
    encrypted_email = Idp::AttributeEncryptor.new.encrypt(email)
    described_class.new(
      encrypted_email: encrypted_email,
      confirmed_at: confirmed_at
    )
  end

  describe '#email' do
    it 'returns the decrypted email' do
      expect(subject.email).to eq(email)
    end
  end

  describe '#confirmed?' do
    context 'when the email has been confirmed' do
      let(:confirmed_at) { 1.day.ago }

      it { expect(subject.confirmed?).to eq(true) }
    end

    context 'when the email has not been confirmed' do
      it { expect(subject.confirmed?).to eq(false) }
    end
  end
end

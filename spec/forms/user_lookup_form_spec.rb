require 'rails_helper'

describe UserLookupForm do
  describe '#submit' do
    context 'when the user exists' do
      it 'lookups up the user and returns it' do
        email = 'lookmeup@example.com'
        user = create(:idp_user, email: email)

        result = subject.submit(email: email)

        expect(result).to eq(user)
        expect(subject.user).to eq(user)
        expect(subject.email).to eq(email)
      end
    end

    context 'when the user does not exist' do
      it 'returns nil' do
        create(:idp_user)
        email = 'cant-find-me@example.com'

        result = subject.submit(email: email)

        expect(result).to eq(nil)
        expect(subject.user).to eq(nil)
        expect(subject.email).to eq(email)
      end
    end
  end
end

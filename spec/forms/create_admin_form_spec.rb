require 'rails_helper'

describe CreateAdminForm do
  describe '#submit' do
    context 'when an admin does not exist for the email' do
      it 'returns true and creates the admin' do
        result = subject.submit(email: 'test@test.com')

        expect(result).to be_truthy
        expect(Admin.where(email: 'test@test.com')).to exist
      end
    end

    context 'when an admin does exist for the email' do
      it 'returns false and saves an error' do
        create(:admin, email: 'test@test.com')

        result = subject.submit(email: 'test@test.com')

        expect(result).to be_falsey
        expect(subject.errors[:email]).to include('already taken')
      end
    end

    context 'when the email is incorrectly formatted' do
      it 'returns false and saves an error' do
        result = subject.submit(email: 'noisy noise')

        expect(result).to be_falsey
        expect(subject.errors[:email]).to include('is invalid')
        expect(Admin.where(email: 'test@test.com')).to_not exist
      end
    end

    context 'when the email is nil or blank' do
      it 'returns false and saves an error' do
        nil_form = CreateAdminForm.new
        nil_result = nil_form.submit(email: nil)
        expect(nil_result).to be_falsey
        expect(nil_form.errors[:email]).to include("can't be blank")

        blank_form = CreateAdminForm.new
        blank_result = blank_form.submit(email: nil)
        expect(blank_result).to be_falsey
        expect(blank_form.errors[:email]).to include("can't be blank")
      end
    end
  end
end

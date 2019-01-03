require 'rails_helper'

describe Idp::Fingerprinter do
  describe '.fingerprint' do
    it 'should fingerprint the value correctly' do
      value = 'this is a test'
      expected_result = '081155006c6c458e59371695aaf0eced8d55b37943d634a0cdeabbe7c6c9b0c1'

      result = described_class.fingerprint(value)

      expect(result).to eq(expected_result)
    end
  end
end

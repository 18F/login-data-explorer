require 'rails_helper'

describe Idp::AttributeDecryptor do
  describe '#decrypt' do
    it 'decrypts an ecrypted string' do
      ciphertext = 'eyJpdiI6IkpldXZMejFYRUVpeEFoQ1oiLCJjaXBoZXJ0ZXh0IjoiM3I
                    3Yi9ETEtDUTcvS2V3cXljUT0iLCJ0YWciOiI2RnovSlZpWDBWMmRDTT
                    lpMGkrM1hBPT0ifQ=='.gsub(/\n +/, '')
      plaintext = 'this is a test'

      result = subject.decrypt(ciphertext)

      expect(result).to eq(plaintext)
    end

    it 'raises an error if decryption fails'
  end
end

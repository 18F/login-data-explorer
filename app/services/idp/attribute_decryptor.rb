module Idp
  class AttributeDecryptor
    def decrypt(ciphertext)
      decoded_ciphertext = Base64.decode64(ciphertext)
      parsed_ciphertext = JSON.parse(decoded_ciphertext, symbolize_names: true)
      decipher(parsed_ciphertext)
    end

    private

    def decipher(parsed_ciphertext)
      cipher = OpenSSL::Cipher.new 'aes-256-gcm'
      cipher.decrypt
      cipher.key = Figaro.env.attribute_encryption_key
      cipher.iv = Base64.decode64(parsed_ciphertext[:iv])
      cipher.auth_tag = Base64.decode64(parsed_ciphertext[:tag])
      cipher.auth_data = 'PII'
      cipher.update(
        Base64.decode64(parsed_ciphertext[:ciphertext])
      ) + cipher.final
    end
  end
end

module Idp
  class AttributeEncryptor
    def encrypt(plaintext)
      cipher = OpenSSL::Cipher.new 'aes-256-gcm'
      cipher.encrypt
      cipher.key = Figaro.env.attribute_encryption_key
      iv = cipher.random_iv
      cipher.auth_data = 'PII'
      ciphertext = cipher.update(plaintext) + cipher.final
      tag = cipher.auth_tag

      Base64.strict_encode64(
        {
          iv: Base64.strict_encode64(iv),
          ciphertext: Base64.strict_encode64(ciphertext),
          tag: Base64.strict_encode64(tag),
        }.to_json
      )
    end
  end
end

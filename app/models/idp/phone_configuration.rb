module Idp
  class PhoneConfiguration < IdpRecord
    belongs_to :user

    def phone
      Idp::AttributeDecryptor.new.decrypt(encrypted_phone)
    end

    def confirmed?
      confirmed_at.present?
    end
  end
end

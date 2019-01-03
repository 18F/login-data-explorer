module Idp
  class EmailAddress < IdpRecord
    belongs_to :user

    def email
      Idp::AttributeDecryptor.new.decrypt(encrypted_email)
    end

    def confirmed?
      confirmed_at.present?
    end
  end
end

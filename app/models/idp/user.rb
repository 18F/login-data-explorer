module Idp
  class User < IdpRecord
    has_many :email_addresses
    has_many :events
    has_many :phone_configurations
    has_many :webauthn_configurations
  end
end

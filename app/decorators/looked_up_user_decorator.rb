class LookedUpUserDecorator
  attr_reader :user

  delegate :email_addresses, :phone_configurations, :webauthn_configurations,
           to: :user

  def initialize(user)
    @user = user
  end

  def piv_cac_enabled?
    user.x509_dn_uuid.present?
  end

  def totp_enabled?
    user.encrypted_otp_secret_key.present?
  end

  def recent_events
    user.events.order(created_at: :desc).limit(50)
  end
end

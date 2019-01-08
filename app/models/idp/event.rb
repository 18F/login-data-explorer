module Idp
  class Event < IdpRecord
    enum event_type: {
      account_created: 1,
      phone_confirmed: 2,
      password_changed: 3,
      phone_changed: 4,
      email_changed: 5,
      authenticator_enabled: 6,
      authenticator_disabled: 7,
      account_verified: 8,
      usps_mail_sent: 9,
      piv_cac_enabled: 10,
      piv_cac_disabled: 11,
      new_personal_key: 12,
      personal_key_used: 13,
      webauthn_key_added: 14,
      webauthn_key_removed: 15,
      phone_removed: 16,
    }

    belongs_to :user

    def event_name
      event_type&.humanize
    end

    def date
      created_at.in_time_zone('Eastern Time (US & Canada)').strftime('%B %e, %Y at %l:%M %p')
    end
  end
end

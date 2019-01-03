module Idp
  class WebauthnConfiguration < IdpRecord
    belongs_to :user
  end
end

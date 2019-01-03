class UserLookupForm
  include ActiveModel::Model

  attr_reader :email, :user

  def submit(params)
    @email = params[:email]
    email_fingerprint = Idp::Fingerprinter.fingerprint(email)
    @user = Idp::EmailAddress.find_by(email_fingerprint: email_fingerprint)&.user
  end
end

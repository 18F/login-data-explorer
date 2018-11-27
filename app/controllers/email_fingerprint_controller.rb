class EmailFingerprintController < ApplicationController
  def index
  end

  def create
    @email = params[:email]
    @fingerprint = fingerprint_for(@email)
    redirect_to "/blazer/queries/1-events-for-specific-user?email_fingerprint=#{@fingerprint}"
  end

  private

  def fingerprint_for(email)
    digest = OpenSSL::Digest::SHA256.new
    key = Figaro.env.hmac_fingerprinter_key
    OpenSSL::HMAC.hexdigest(digest, key, email)
  end
end

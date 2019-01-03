module Idp
  class Fingerprinter
    def self.fingerprint(value)
      digest = OpenSSL::Digest::SHA256.new
      key = Figaro.env.hmac_fingerprinter_key
      OpenSSL::HMAC.hexdigest(digest, key, value)
    end
  end
end

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :login_dot_gov, {
    client_id: Figaro.env.oidc_client_id,
    idp_base_url: Figaro.env.oidc_idp_base_url,
    ial: 1,
    private_key: OpenSSL::PKey::RSA.new(File.read('config/admin_console_dev.pem')),
    redirect_uri: Figaro.env.oidc_client_redirect_uri,
  }
end

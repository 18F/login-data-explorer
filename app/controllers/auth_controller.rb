class AuthController < ApplicationController
  skip_before_action :authenticate_admin!

  def new
    admin = Admin.find_by(email: admin_params['email'])
    if admin.present?
      admin.update!(uuid: admin_params['uuid'])
      sign_in admin
      redirect_to blazer_url
    else
      flash[:alert] = 'You are not authorized to access the admin console'
      redirect_to root_url
    end
  end

  def admin_params
    request.env['omniauth.auth']['info'].slice('email', 'uuid')
  end

  def destroy
    sign_out current_admin if admin_signed_in?
    redirect_to root_url
  end
end

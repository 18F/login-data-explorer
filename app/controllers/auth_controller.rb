class AuthController < ApplicationController
  def callback
    render json: request.env['omniauth.auth']
  end
end

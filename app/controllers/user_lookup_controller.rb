class UserLookupController < ApplicationController
  before_action :set_user_lookup_form

  def new
  end

  def create
    @user_lookup_form.submit(user_lookup_params.to_h)
    if @user_lookup_form.user.nil?
      flash[:alert] = "Unable to find a user with email #{@user_lookup_form.email}"
      return render(:new)
    end
    @decorated_user = LookedUpUserDecorator.new(@user_lookup_form.user)
  end

  private

  def set_user_lookup_form
    @user_lookup_form ||= UserLookupForm.new
  end

  def user_lookup_params
    params.require(:user_lookup_form).permit(:email)
  end
end

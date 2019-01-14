class AdminsController < ApplicationController
  def new
    create_admin_form
  end

  def create
    if create_admin_form.submit(admin_params)
      flash[:notice] = 'Admin created'
      redirect_to admins_url
    else
      render :new
    end
  end

  def index
    @admins = Admin.order(created_at: :asc)
  end

  def destroy
    admin_id = params[:id]
    flash[:notice] = if Admin.find(admin_id)&.destroy
                       'Admin deleted successfully'
                     else
                       "Unable to delete admin with id: #{admin_id}"
                     end
    redirect_to admins_url
  end

  private

  def admin_params
    params.require(:create_admin_form).permit(:email)
  end

  def create_admin_form
    @create_admin_form ||= CreateAdminForm.new
  end
end

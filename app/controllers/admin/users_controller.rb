class Admin::UsersController < ApplicationController
	layout "admin"
	before_action :authenticate_user!
	before_action :admin_required
def index
	@users = User.all
end

def to_admin
	@user = User.find(params[:id])
	@user.to_admin
	redirect_to admin_users_path
end

def to_normal
  @user = User.find(params[:id])
  if !current_user
  	@user.to_normal
 	redirect_to admin_users_path
  else
  	flash[:warning] = "Illegal operation attempted on current user"
	redirect_to admin_users_path
  end
end

end

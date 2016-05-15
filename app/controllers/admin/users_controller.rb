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
	flash[:warning] = "User level changed"
	redirect_to admin_users_path
end

def to_normal
  @user = User.find(params[:id])
  if current_user.email == @user.email
  	flash[:alert] = "Illegal operation attempted on current user. You're loggin as",(current_user.email)
	redirect_to admin_users_path
  else
  	@user.to_normal
 	flash[:warning] = "User level changed"
 	redirect_to admin_users_path
  end
end

end

class Admin::UsersController < ApplicationController
  layout "admin"

  before_action :authenticate_user!
  before_action :admin_required
  
  def index
    @users = User.all
  end
  
  def to_admin
    @user = User.find(params[:id])
    if @user.to_admin
      flash[:success] = "User was changed to admin status."
    else
      flash[:error] = "User was not changed to admin status."
    end
    redirect_to admin_users_path
  end

  def to_normal
    @user = User.find(params[:id])
    if @user.to_normal
      flash[:success] = "User was changed to normal status."
    else
      flash[:error] = "User was not changed to normal status."
    end
    redirect_to admin_users_path
  end
end

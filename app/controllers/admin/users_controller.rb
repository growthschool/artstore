class Admin::UsersController < ApplicationController
  layout "admin"

  before_action :authenticate_user!
  before_action :admin_required

  def index
    @users = User.all
  end

  def to_admin
    u = User.find(params[:user_id])
    u.to_admin

    redirect_to admin_users_path
  end

  def to_normal
    u = User.find(params[:user_id])
    u.to_normal

    redirect_to admin_users_path
  end
end

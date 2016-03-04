class Admin::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_required

  layout "admin"

  def index
    @users = User.all
  end

  def to_admin
    @user = User.find(params[:id])
    @user.to_admin
    redirect_to admin_users_path, notice: "已經轉為管理者"
  end

  def to_normal
    @user = User.find(params[:id])
    @user.to_normal
    redirect_to admin_users_path, notice: "已經轉為一般使用者"
  end
end

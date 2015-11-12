class Admin::UsersController < ApplicationController

  layout "admin"   # 叫admin/user controller的layout使用admin_html.erb而非預設的application.html.erb

  before_action :authenticate_user!
  before_action :admin_required

  def index
    @users = User.all
  end

  def to_admin
    @user = User.find(params[:user_id])
    @user.to_admin

    redirect_to admin_users_path
  end

  def to_normal
    @user = User.find(params[:user_id])
    @user.to_normal

    redirect_to admin_users_path
  end
end

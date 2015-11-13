class Admin::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_required
  layout 'admin'
  
  def index
    @users = User.all
  end
  def transfer
    @user = User.find(params[:user_id])
    @user.update(is_admin: !@user.admin?)
    flash[:success] = 'done.'
    redirect_to :back
  end

  private
  def user_params
    params.require(:user).permit(:is_admin)
  end
end

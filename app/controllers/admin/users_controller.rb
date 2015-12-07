class Admin::UsersController < AdminController

  before_action :find_user_by_id, only: [:edit, :update]

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
    @user.to_normal
    redirect_to admin_users_path
  end

  # def show
  #   @user = User.find(params[:id])
  # end

  # def edit
  # end

  # def update
  #   if @user.save
  #     redirect_to admin_users_path
  #   else
  #     render :index
  #   end
  # end

  private
  def user_params
    params.require(:user).permit.(:is_admin)
  end

  private
  def find_user_by_id
    @user = User.find(params[:id])
  end
end

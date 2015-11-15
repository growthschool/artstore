class Admin::UsersController < ApplicationController
	def index
  		@users = User.all
  	end
	
	def changeAdmin
    	@user = User.find(params[:id])
    	@user.is_admin = !@user.is_admin;
    	if @user.save
      		redirect_to admin_users_path
    	else
      		render :index
    end
  end
end

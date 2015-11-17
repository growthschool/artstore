class Admin::UsersController < ApplicationController
	before_action :authenticate_user!
	before_action :admin_required

	layout "admin"

	def index
		@users = User.all
	end

	def to_admin
		@user = User.find(params[:id])
		if !@user.is_admin
			@user.make_admin
			redirect_to admin_users_path, notice: "將#{@user.email}更改為admin!"
		else
			redirect_to admin_users_path, notice: "#{@user.email}已經是admin!"
		end
	end

	def to_user
		@user = User.find(params[:id])
		if @user.is_admin
			@user.make_user
			redirect_to admin_users_path, notice: "將#{@user.email}更改為一般用戶!"
		else
			redirect_to admin_users_path, notice: "#{@user.email}已經是一般用戶!"
		end
	end

end

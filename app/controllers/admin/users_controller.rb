class Admin::UsersController < ApplicationController
	layout "admin"

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

	def to_user
		@user = User.find(params[:user_id])
		@user.to_user

		redirect_to admin_users_path
	end
end

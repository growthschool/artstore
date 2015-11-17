class Admin::UsersController < ApplicationController
	before_action :authenticate_user!
	before_action :admin_required

	layout "admin"

	def index
		@users = User.all
	end
end

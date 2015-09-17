class Admin::OrdersController < ApplicationController
	before_action :authenticate_user!
	before_action :admin_required

	def index
		@orders = Order.all.order("created_at DESC")
	end

	def show
		@order = Order.find(params[:id])
	end
end

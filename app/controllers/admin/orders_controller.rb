class Admin::OrdersController < ApplicationController

	layout "admin"

	# 必須要可以登入
	before_action :authenticate_user!
	# 使用者必須是 admin
	before_action :admin_required
	
	def index
		@orders = Order.all
	end

	def show
		@order = Order.find(params[:id])
		@order_info = @order.info
		@order_items = @order.items
	end

	def ship
		@order = Order.find(params[:id])
		@order.ship!
		redirect_to :back
	end

	def shipped
		@order = Order.find(params[:id])
		@order.deliver!
		redirect_to :back
	end

	def cancel
		@order = Order.find(params[:id])
		@order.cancel_order!
		redirect_to :back
	end

	def return
		@order = Order.find(params[:id])
		@order.return_good!
		redirect_to :back
	end
end

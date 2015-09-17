class Admin::OrdersController < ApplicationController
	before_action :authenticate_user!
	before_action :admin_required
	before_action :find_order, except: [:index]

	def index
		@orders = Order.all.order("created_at DESC")
	end

	def show
		@order_info = @order.info
		@order_items = @order.items
	end

	def ship
		@order.ship!
		redirect_to :back
	end

	def shipped
		@order.deliver!
		redirect_to :back
	end

	def cancel
		@order.cancel_order!
		redirect_to :back
	end

	def return
		@order.return_good!
		redirect_to :back
	end

	private
		def find_order
			@order = Order.find(params[:id])
		end
end

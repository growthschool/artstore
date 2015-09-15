class CartsController < ApplicationController
	before_action :authenticate_user!, only: [:checkout]

	def index
	end

	def show
	end

	def checkout
		@order = current_user.orders.build
		@info = @order.build_info
	end

	def clean
		@cart = Cart.find(params[:cart_id])
		@cart.items.clear
		redirect_to :back
	end
end

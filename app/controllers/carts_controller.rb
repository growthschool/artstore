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

end

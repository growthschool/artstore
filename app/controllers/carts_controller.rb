class CartsController < ApplicationController

	before_action :authenticate_user!, only: [:checkout]
	def index
		@cart = current_cart
	end

	def checkout
		@order = current_user.orders.build
		@info = @order.build_info
	end
end

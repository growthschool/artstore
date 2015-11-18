class CartsController < ApplicationController
	before_action :authenticate_user!, only: [:checkout]

	def checkout
		@order = current_user.orders.build
		@info = @order.build_info
	end
end

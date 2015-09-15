class ProductsController < ApplicationController
	def index
		@products = Product.order("id DESC")
	end

	def show
		@product = Product.find(params[:id])
	end

	def add_to_cart
		redirect_to :back
	end
end

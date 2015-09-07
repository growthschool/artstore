class Admin::ProductsController < ApplicationController

	# 必須要可以登入
	before_action :authenticate_user!

	def index
		@products = Product.all
	end

	def new
		@product = Product.new
	end

	def create
		@product = Product.new(product_params)
		
		if @product.save
			redirect_to admin_products_path
		else
			render :new
		end
	end

	private

	def product_params
		params.require(:product).permit(:title, :description, :quantity, :price)
	end
end

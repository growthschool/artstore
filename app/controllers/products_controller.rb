class ProductsController < ApplicationController
	def index
		@products = Product.all
	end

	def show
		@product = Product.find(params[:id])
	end

	def add_to_cart
		@product = Product.find(params[:id])
		current_card.add_product_to_cart(@product)
		flash[:notice] = "Add #{@product.title} Success!"
		redirect_to :back
	end
end

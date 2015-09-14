class ProductsController < ApplicationController
	def index
		@products = Product.all.order("created_at DESC")
	end

	def show
		@products = Product.find(params[:id])
	end

	def add_to_cart
		@product = Product.find(params[:id])

		if !current_cart.items.include?(@product)
			current_cart.add_product_to_cart(@product)
			flash[:notice] = "#{@product.title}已成功加入購物車"
		else
			flash[:alert] = "#{@product.title}已在購物車裡"
		end

		redirect_to :back
	end
end

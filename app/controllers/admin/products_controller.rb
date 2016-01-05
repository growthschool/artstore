class Admin::ProductsController < ApplicationController
	layout "admin"

	before_action :authenticate_user!
	before_action :admin_required
	
	def new
		@product = Product.new
		/build_photo 這是產生關聯後的一種method/
		@photo = @product.build_photo
	end
	def create
		@product = Product.new(product_params)
		if @product.save
			redirect_to admin_products_path
		else
			render :new
		end
	end
	
	def index
		@products = Product.all
	end

	def show
		@product = Product.find(params[:id])
	end

	def edit
		@product = Product.find(params[:id])
		if @product.photo.present?
			@photo = @product.photo
		else
			@photo = @product.build_photo
		end
	end
	
	def update
		@product = Product.find(params[:id])
		if @product.update
			redirect_to admin_products_path
		else
			render :edit
		end
	end

	def destroy
		@product = Product.find(params[:id])
	end

private
	def product_params
		params.require(:product).permit(:title, :description, :quantity, :price, photo_attributes: [:image, :id])
	end

end

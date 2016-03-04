class Admin::ProductsController < ApplicationController
   layout "admin"

   before_action :authenticate_user!

   	def index
    	@products = Product.all
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

		if @products.update(product_params)
			redirect_to admin_products_path
		else
			render :edit
		end
	end

	def new
    	@product = Product.new
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

  	private

  	def product_params
    	params.require(:product).permit(:title, :description, :quantity, :price,
													photo_attributes: [:image, :id])
  	end
end

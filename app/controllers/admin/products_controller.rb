class Admin::ProductsController < ApplicationController

layout "admin"

# devise helper
before_action :authenticate_user!

# admin_required helper (application_controller)
before_action :admin_required

def index
	@products = Product.all
end


def show
	@product = Product.find(params[:id])
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

def edit
	@product = Product.find(params[:id])
	
	# what's this???
	@photo = @product.photo
end

def update
	@product = Product.find(params[:id])

	if @product.update(product_params)
		redirect_to admin_products_path
	else
		render :edit
	end
end

private

def product_params
	params.require(:product).permit(:title, :description, :quantity, :price, photo_attributes: [:image, :id])
	
end

end

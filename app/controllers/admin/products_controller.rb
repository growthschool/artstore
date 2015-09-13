class Admin::ProductsController < ApplicationController
	before_action :authenticate_user!
	before_action :admin_required
	before_action :find_product, only: [:show, :edit, :update, :destroy]

	def index
		@products = Product.all.order("created_at DESC")
	end

	def show

	end

	def new
		@product = Product.new
		@photo = @product.photos.new
	end

	def create
		@product = Product.new(product_params)

		if @product.save
			redirect_to admin_products_path, notice: "商品新增成功"
		else
			render :new
		end
	end

	def edit
		@photos = @product.photos.build
	end

	def update
		@photos = @product.photos.build
		if @product.update(product_params)
			redirect_to admin_products_path, notice: "商品修改成功"
		else
			render :edit
		end
	end

	def destroy
		@product.destroy
		redirect_to admin_products_path, notice: "商品已刪除"
	end

	private
		def product_params
			params.require(:product).permit(:title, :description, :quantity, :price,
											photos_attributes: [:image])
		end

		def find_product
			@product = Product.find(params[:id])	
		end
end

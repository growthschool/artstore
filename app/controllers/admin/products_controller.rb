class Admin::ProductsController < ApplicationController
 def index
 end

layout "admin"

 before_action :authenticate_user!
 before_action :admin_required

 def index
   @products = Product.order("id DESC")
 end

 def show
  @product = Product.find(params[:id])
  end


 def new
  @product = Product.new
  @photo = @product.photos.new
 end

 def edit
  @product = Product.find(params[:id])
  @photo = @product.photos.build
 end

def add_to_cart
  @product = Product.find(params[:id])

  Current_cart.add_product_to_cart(@product)

  redirect_to :back

end


 def create
  @product = Product.new(product_params)

  if @product.save
    redirect_to admin_products_path
 else
   render :new
 end
end

def update
  @product = Product.find(params[:id])
  @photo = @product.photos.build
  if @product.update(product_params)
    redirect_to admin_products_path
  else
    render :edit
  end
end


private

def product_params
  params.require(:product).permit(:title, :description, :quantity, :price,
                                photos_attributes: [:image])

end

end

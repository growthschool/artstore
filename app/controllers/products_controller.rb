class ProductsController < ApplicationController
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
end

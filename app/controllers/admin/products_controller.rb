class Admin::ProductsController < ApplicationController
  layout "admin"
  before_action :authenticate_user!
  before_action :admin_required

  def new
    @product = Product.new
    @photos = @product.photos.new
  end
 
  def create
    @product = Product.new(product_params)
    @photos = @product.photos.new
 
    if @product.save
      redirect_to admin_products_path
    else
      render :new
    end
  end
 
  def index
    @products = Product.all
  end

  def edit
    @product = Product.find(params[:id])
  end

  
 
  private
 
  def product_params
    params.require(:product).permit(:title, :description, :quantity, :price, :photos_attributes => [:image])
  end
end

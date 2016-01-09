class Admin::ProductsController < ApplicationController
  layout 'admin'
  
  before_action :authenticate_user!
  before_action :admin_required
  before_action :set_product, only: [:edit, :update, :destroy]
  
  def index
     @products = Product.all
  end
  
  def new
    @product = Product.new
    @product.build_photo
  end

  def create
    @product = Product.new(product_params)
    # @product.avatar = params[:avatar]
    if @product.save
      flash[:success] = "Product was created."
      redirect_to admin_products_path
    else
      flash.now[:error]  =  "Product was not created."
      render :new
    end
  end
  
  def edit
    if @product.photo.present?
      @photo = @product.photo
    else
      @photo = @product.build_photo
    end
  end

  def update
    if @product.update(product_params)
      flash[:success] = "Product was updated."
      redirect_to admin_products_path
    else
      flash.now[:error]  =  "Product was not updated."
      render :edit
    end
  end
  
  def destroy
    if @product.delete
      flash[:warning] = "Product was deleted."
    else
      flash[:error] = "Product was not deleted."
    end
    redirect_to admin_products_path
  end

  private

    def set_product
      @product = Product.find_by_id(params[:id])
    end

    def product_params
      params.require(:product).permit(:title, :description, :quantity, :price, photo_attributes: [:id, :avatar])
    end
  
end

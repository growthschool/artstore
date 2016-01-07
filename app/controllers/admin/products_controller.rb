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
      flash.now[:notice] = 'Product was created.'
      render :show
    else
      flash.now[:alert]  =  'Product was not created.'
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
      flash.now[:notice] = 'Product was updated.'
      render :show
    else
      flash.now[:alert]  =  'Product was not updated.'
      render :edit
    end
  end
  
  def destroy
    if @product.delete
      flash[:warning] = 'Product was deleted.'
    else
      flash[:alert] = 'Product was not deleted!'
    end
    redirect_to :index
  end

  private

    def set_product
      @product = Product.find_by_id(params[:id])
    end

    def product_params
      params.require(:product).permit(:title, :description, :quantity, :price, photo_attributes: [:id, :avatar])
    end
  
end

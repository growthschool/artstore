class Admin::ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_required

  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
    @product.photos.build
  end

  def edit
    #code
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to admin_product_path(@product)
    else
      render :new
    end
  end

  def update
    #code
  end

  def destroy
    #code
  end

  private

  def product_params
    params.require(:product).permit(:title, :description, :quantity, :price,
      photos_attributes: :image)
  end
end

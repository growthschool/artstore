class Admin::ProductsController < ApplicationController

  before_action :authenticate_user!

  # self-defined function
  before_action :admin_required

  def index
    @products = Product.all
  end

  # is a page
  def edit
    @product = Product.find(params[:id])

    if @product.photo.present?
      @photo = @product.photo
    else
      @photo = @product.build_photo
    end
  end

  # is an action
  def update
    @product = Product.find(params[:id])

    if @product.update(product_params)
      redirect_to admin_products_path
    else
      render :edit
    end
  end

  # is a page
  def new
    @product = Product.new
    @photo = @product.build_photo
  end

  # is an action
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
    params.require(:product).permit(:title, :description, :quantity, :price, photo_attributes: [:image, :id])
  end
end

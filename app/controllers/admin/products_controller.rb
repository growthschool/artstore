class Admin::ProductsController < ApplicationController
  layout "admin"
  before_action :authenticate_user!
  before_action :admin_required
  def index
    @products = Product.all
  end

  def new
    @product = Product.new
    @photo = @product.photos.new
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

  def edit
    @product = Product.find(params[:id])
    @photo = @product.photos.build
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to admin_products_path, alert: "商品已刪除"
  end


  private

    def product_params
      params.require(:product).permit(:title, :description, :quantity, :price,  photos_attributes: [:image])
    end
end

class Admin::ProductsController < ApplicationController
  layout "admin"
  before_action :authenticate_user!
  before_action :admin_required

  def index
    @products = Product.order("id desc")
  end

  def new
    @product = Product.new
    @photo = @product.photos.new
  end

  def create
    @product = Product.new(products_params)

    if @product.save
      redirect_to admin_products_path , notice: "商品新增成功"
    else
      render :new
    end

  end

  def edit

    @product = Product.find(params[:id])
    @photo =@product.photos.build

  end

  def update

    @product = Product.find(params[:id])
    @photo =@product.photos.build

    if @product.update(products_params)

      redirect_to admin_products_path ,notice: "商品修改成功"

    else
      render :edit
    end


  end

  private
   def products_params
      params.require(:product).permit(:title,:description,:price,:quantity,photos_attributes: [:image])
   end
end

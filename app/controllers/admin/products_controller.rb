class Admin::ProductsController < ApplicationController

  before_action :authenticate_user!
  before_action :admin_required

  def index
    #@products = Product.all
    @products = Product.order("id DESC")
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
    @photo = @product.photos.new
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      redirect_to admin_products_path(@product), notice: "新增產品成功！"
    else
      render :new
    end
  end

  def edit
    @product = Product.find(params[:id])
    #@product = Product.find(params[:product_id])
    #@product = Product.find(1)
  end

  def update
    @product = Product.find(params[:id])

    if @product.update(product_params)
      redirect_to admin_products_path(@product), notice: "修改產品成功！"
    else
      render :edit
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to admin_products_path(@product), notice: "產品已刪除！"
  end

  private

  def product_params
    params.require(:product).permit(:title, :description, :quantity, :price, photos_attributes: [:image])
  end




end

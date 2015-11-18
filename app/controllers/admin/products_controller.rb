class Admin::ProductsController < ApplicationController

  layout "admin"
  # AOP Start---
  before_action :authenticate_user!

  # 驗證身份，必須是admin身份。此method 因為是Global函數，
  # 所以定義在ApplicationController
  before_action :admin_required

  # ---AOP End
  def index
    @products = Product.all
  end

  def new
    @product = Product.new
    @photo = @product.build_photo
  end

  def edit
    @product = Product.find(params[:id])
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

    if @product.update(product_params)
      redirect_to admin_products_path
    else
      render :edit
    end
  end

  private
  def product_params
    # 設定只能進入DB的欄位
    params.require(:product).permit(:title, :description, :quantity, :price, photo_attributes:[:image, :id])
  end
end

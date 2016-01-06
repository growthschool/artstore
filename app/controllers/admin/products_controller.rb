class Admin::ProductsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :update, :destroy]
  before_action :admin_required, only: [:new, :edit, :update, :destroy]
  before_action :find_product, only: [:show, :edit, :update, :destroy]
  def new
    @product = Product.new 
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to admin_products_path
    else
      render :new
    end
  end

  def show
    
  end

  def index
    @products = Product.all
  end

  def edit
    
  end

  def update
    
  end

  def destroy
    
  end

  private

  def product_params
    params.require(:product).permit(:title, :description, :quantity, :price)
  end

  def find_product
    @product = Product.find(params[:id])
  end
end

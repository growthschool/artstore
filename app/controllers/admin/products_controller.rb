class Admin::ProductsController < ApplicationController

  before_action :authenticate_user!  #必須要先登入才能存取後台
  before_action :admin_required      #登入後台的使用者必須是admin

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

  def index                    #建立後台產品列表
    @products = Product.all
  end


  private

  def product_params
    params.require(:product).permit(:title, :description, :quantity, :price)
  end

end

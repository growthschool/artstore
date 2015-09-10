class Admin::ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_required


  def index
    @products = Product.all
  end


  def new
    @product = Product.new

  end


  def create
    @product = Product.new(params_product)

    if @product.save
      redirect_to admin_products_path
    else
      render :new
    end

  end




private

  def params_product
    params.require(:product).permit(:title, :description, :quantity, :price)
  end

end

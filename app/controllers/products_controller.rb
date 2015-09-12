class ProductsController < ApplicationController

  def index
    @products = Product.order("id desc")
  end
  def show
    @product = Product.find(params[:id])
  end

end

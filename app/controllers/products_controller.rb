class ProductsController < ApplicationController
  def index
    @products = Product.order(id: :desc).all
  end

  def show
    @product = Product.find(params[:id])
  end
end

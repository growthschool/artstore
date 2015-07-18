class ProductsController < ApplicationController

  def index
  	@products = Product.order("id DESC")
  end

  def show
  	@product = Product.find_by(params[:id])
  end

end

class ProductsController < ApplicationController
  #before_action :authenticate_user!

  def index
    #@products = Product.all
    @products = Product.order("id DESC")
  end

  def show
    @product = Product.find(params[:id])
  end


end

class ProductsController < ApplicationController
  before_action :set_product, except: [:new, :create, :index]

  def show
    
  end

  def index
    @products = Product.all
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

end
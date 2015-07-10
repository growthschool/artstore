class ProductsController < ApplicationController

  def index
    @products = Product.order("id DESC")
  end
end

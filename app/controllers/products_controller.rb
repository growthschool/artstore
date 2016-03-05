class ProductsController < ApplicationController
def index
  @products = Product.all
end

def show

  @productd =  Product.find(param[:id])
end
end

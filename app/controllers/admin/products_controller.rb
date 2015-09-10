class Admin::ProductsController < ApplicationController

  def new
    @product = Product.new

  end


  def create
    @product = Product.new(params_product)

    if @product.save
      redirect_to admin_product_path
    else
      render :new
    end

  end




private

  def params_product
    params.require(:product).permit(:title, :description, :quantity, :price)
  end

end

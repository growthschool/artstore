class Admin::ProductsController < ApplicationController
  
  layout "admin"
  
  before_action :authenticate_user!
  before_action :admin_required

  def new
    @product = Product.new
    @photo = @product.photos.new
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      redirect_to admin_products_path
    else
      render :new
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])

    if @product.update(product_params)
      redirect_to admin_products_path
    else
      render :edit
    end
  end
  
  def index
    @products = Product.all
  end

  def add_to_cart
 
    @product = Product.find(params[:id])
 
    if !current_cart.items.include?(@product)
      current_cart.add_product_to_cart(@product)
      flash[:notice] = "你已成功將 #{@product.title} 加入購物車"
    else
      flash[:warning] = "你的購物車內已有此物品"
    end
 
    redirect_to :back
 
  end

  private

  def product_params
    params.require(:product).permit(:title, :description, :quantity, :price, :photos_attributes => [:image] )
  end

end

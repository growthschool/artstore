class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def show
    @product = Product.find params[:id]
  end

  def add_to_cart
    cid = session[:cart_id]
    if cid.nil?
      c = Cart.create
      session[:cart_id] = c.id
    else
      c = Cart.find_by(id: cid)
      if c.nil?
        c = Cart.new
        session[:cart_id] = c.id
      end
    end

    @product = Product.find(params[:id])

    if c.items.include?(@product)
      flash[:warning] = "already have"
    else
      c.items << @product
      flash[:notice] = "add ok"
    end

    redirect_to :back
  end
end

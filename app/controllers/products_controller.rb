class ProductsController < ApplicationController
	def index
		@products = Product.order("id DESC")		
	end

	def show
		@product = Product.find(params[:id])		
	end

	def add_to_cart		
		@product = Product.find(params[:id])
        if !current_cart.items.include?(@product)
		   current_cart.add_product_to_cart(@product)
		   flash[:notice] = "You added #{@product.title} to the shopping cart successfully."
        else
           flash[:warning] = "Your cart have a same item!!"
        end        
        redirect_to :back		
	end

	

end

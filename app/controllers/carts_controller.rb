class CartsController < ApplicationController
  
  
  def show
    @items = current_cart.items
  end
  
  def checkout
    
  end
end

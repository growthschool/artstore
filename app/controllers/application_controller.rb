class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def admin_required
    if !current_user.admin?
      redirect_to "/"
    end
  end


  #將current_cart宣告為helper 因為helper為全域所以M、V、C都能使用
  helper_method :current_cart
 
  def current_cart
    @current_cart ||= find_cart
  end


 
  def find_cart
 
    cart = Cart.find_by(id: session[:cart_id])
 
    unless  cart.present?
      cart = Cart.create
    end
 
    session[:cart_id] = cart.id
    cart
  end
 
end

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  

  def admin_required

    if !current_user.admin?  #current_user判斷user是否登入;讀取user的admin欄位,驗證是否為admin.
      redirect_to "/"  #若尚未登入則導到
    end
  end

  def current_cart
    @current_cart ||= find_cart
  end
 
  helper_method :current_cart
  
  def find_cart
 
    cart = Cart.find_by(id: session[:cart_id])
 
    unless  cart.present?
      cart = Cart.create
    end
 
    session[:cart_id] = cart.id
    cart
  end

end

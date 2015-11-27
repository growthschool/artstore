class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_cart
  # 若要讓views也能用就要加上helper_method

  def current_cart
    @current_cart ||= find_cart
  end
# 如果 @current_cart  不為空 回傳@current
# 否則執行find_cart



  def admin_required
    if !current_user.admin?
      redirect_to "/"
    end
  end

  private

  def find_cart
    cart = Cart.find_by(id: session[:cart_id]) || Cart.create
    session[:cart_id] = cart.id
    cart

  end

end

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def admin_required
    if !current_user.admin?
      redirect_to "/"
    end
  end

  def current_cart
    @current_cart ||= find_cart
  end

  private
  def find_cart
    cart = Cart.find_by(id: session[:cart_id])
    unless cart.present?
      cart = Cart.create
      session[:cart_id] = cart.id
    end
    cart
  end

end

class ApplicationController < ActionController::Base

def admin_required
    if !current_user.admin?
      redirect_to "/"
    end
  end
    helper_method :current_cart

  def current_cart
    @current_cart ||= find_cart
  end

  private

  def find_cart
    cart = Cart.find_by(id: session[:cart_id])

    unless cart.present?
      cart = Cart.create
    end

    session[:cart_id] = cart.id
    cart
  end
end
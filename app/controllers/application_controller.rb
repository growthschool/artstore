class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Devise strong parameters
  before_action :configure_permitted_parameters, if: :devise_controller?

  # Redirect path for after user signs in
  def after_sign_in_path_for(current_user)
    admin_products_path
  end

  # General user's admin status check & redirect
  def admin_required
    if !current_user.admin?
      redirect_to("/")
    end
  end

  # Make current_car a helper method
  helper_method :current_cart

  def current_cart
    @current_cart ||= find_cart
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password, :password_confirmation])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:email, :password])
    devise_parameter_sanitizer.permit(:account_update, keys: [:email, :password, :password_confirmation, :current_password])
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

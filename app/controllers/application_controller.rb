class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


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
      # if !cart.present? #測試看看直觀寫法行不行。if cart 不存在
      cart = Cart.create
    end

    session[:cart_id] = cart.id
    cart
  end



end

# def admin_required
#   if !current_user.admin?
#     redirect_to admin_products_path
#   end
# end

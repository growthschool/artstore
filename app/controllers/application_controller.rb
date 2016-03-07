class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  #view and edit 2016.3.1 18:02 by LaurentLang
  def admin_required
    if !current_user.admin?
      redirect_to "http://tw.yahoo.com"
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

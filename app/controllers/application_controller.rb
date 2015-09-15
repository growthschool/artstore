class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

	# 不是 admin 的話導回首頁
	def admin_required
		if !current_user.admin?
			redirect_to "/"
		end
	end

	# helper_method 可以讓 view 以及 controller 都可以存取到這個 method
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

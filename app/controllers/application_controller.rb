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
end

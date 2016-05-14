class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  def admin_required
		if !current_user.admin?
			flash[:warning] = "Please loggin first"
			redirect_to "/users/sign_in"
		end
	end

end

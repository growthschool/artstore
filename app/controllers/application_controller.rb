class ApplicationController < ActionController::Base # “<”是指繼承
    # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
    def admin_required
      if !current_user.admin? #如果這個人不是admin
        redirect_to "/"  #把它導回首頁
      end
    end
end

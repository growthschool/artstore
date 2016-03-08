module Admin::UsersHelper
  def render_to_normal_user_button(user, current_user)
    if user == current_user
      "這是你的帳號，無法變更"
    else
      link_to("轉為一般使用者", to_normal_admin_user_path(user), method: :post, class: "btn btn-info")
    end
  end
end

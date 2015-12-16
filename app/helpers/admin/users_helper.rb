module Admin::UsersHelper
  def is_admin?(user)
    if user.is_admin == 't'
      return '管理者'
    else
      return '賤民'
    end
  end
end

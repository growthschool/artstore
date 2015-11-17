class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # rememerable 實作remember_me
  #
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

# 我要db吃 "is_admin" 這個欄位 ,須使用 rails g migration add_is_admin_to_user
# 並且到db裡檔案修改 :users, :is_admin, :boolean, defaut: false  # default如果是true那大家都是admin了!
# 因為default: false 無法直接於指令內添加，所以只能另外到db檔案內修改了
  def admin?
    is_admin
  end

# 使用update_columns可直接更改attributes,這裏為is_admin欄位,但會省略掉vailidate和callback等動作，updated_at也不會更新
  def to_admin
    self.update_columns(is_admin: true)
  end

  def to_normal
    self.update_columns(is_admin: false)
  end
end

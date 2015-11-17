class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def admin?
  	is_admin
  end

  def make_admin
 		update!(is_admin: true)
  end

  def make_user
  	update!(is_admin: false)
  end
end

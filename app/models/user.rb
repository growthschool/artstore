class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def admin?
    is_admin
  end

  def to_admin
    self.is_admin = true
    self.save
  end

  def to_normal
    self.is_admin = false
    self.save
  end

end

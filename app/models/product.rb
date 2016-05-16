class Product < ActiveRecord::Base
  has_one :photo
  accepts_nested_attributes_for :photo

  def to_admin
   self.update_columns(is_admin: true)
  end

  def to_normal
   self.update_columns(is_admin: false)
  end
end

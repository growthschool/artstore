class Product < ActiveRecord::Base
  has_one :photo

  accepts_nested_attributes_for :photo

  def reserve_inventory!(quantity)
    self.quantity = self.quantity - quantity
    self.save
  end
end

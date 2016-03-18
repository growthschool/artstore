class Product < ActiveRecord::Base
  has_one :photo

  accepts_nested_attributes_for :photo

  def reduce_goods!(quantity)
    @remain_count = self.quantity - quantity
    self.update_columns(quantity: @remain_count)
  end
end

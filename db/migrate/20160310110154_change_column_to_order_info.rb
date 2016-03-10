class ChangeColumnToOrderInfo < ActiveRecord::Migration
  def change
    rename_column :order_infos, :billin_address, :billing_address
  end
end

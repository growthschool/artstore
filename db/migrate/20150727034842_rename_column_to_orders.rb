class RenameColumnToOrders < ActiveRecord::Migration
  def change
    rename_column :orders, :paymethod, :payment_method
  end
end

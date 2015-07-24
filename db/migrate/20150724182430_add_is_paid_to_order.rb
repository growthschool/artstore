class AddIsPaidToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :is_paid, :boolean, :default => false
    remove_column :orders, :paid
  end
end

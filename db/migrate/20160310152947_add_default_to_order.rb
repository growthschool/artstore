class AddDefaultToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :is_paid, :boolean, default: false
  end
end

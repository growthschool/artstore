class AddStatusToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :status, :string, default: "order_placed"
		add_index :orders, :status
  end
end

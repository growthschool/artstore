class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :user_id
      t.integer :total_id, default: 0

      t.timestamps null: false
    end
  end
end

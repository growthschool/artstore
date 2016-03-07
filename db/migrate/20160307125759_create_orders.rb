class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :user_id
      t.integer :total

      t.timestamps null: false

      t.integer :total, default: 0
    end
  end
end

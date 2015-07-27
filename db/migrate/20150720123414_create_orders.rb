class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :user_id
      t.integer :total
      t.boolean :paid

      t.timestamps null: false
    end
  end
end

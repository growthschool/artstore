class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.references :user, index: true, foreign_key: true
      t.integer :total, default: 0

      t.timestamps null: false
    end
  end
end

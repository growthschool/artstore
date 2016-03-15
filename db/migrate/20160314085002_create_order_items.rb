class CreateOrderItems < ActiveRecord::Migration
  def change
    create_table :order_items do |t|
      t.integer :order_id
      t.string :product_name
      t.integer :quantity
      t.integer :price

      t.timestamps null: false
    end
  end
end

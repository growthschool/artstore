class CreateOrderItems < ActiveRecord::Migration
  def change
    create_table :order_items do |t|
      t.references :order, index: true, foreign_key: true
      t.string :product_name
      t.integer :price
      t.integer :quantity

      t.timestamps null: false
    end
  end
end

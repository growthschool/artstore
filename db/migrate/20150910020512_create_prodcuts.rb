class CreateProdcuts < ActiveRecord::Migration
  def change
    create_table :prodcuts do |t|
      t.string :title
      t.text :description
      t.integer :quantity
      t.integer :price

      t.timestamps null: false
    end
  end
end

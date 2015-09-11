class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :title
      t.text :description
      t.string :quantity
      t.string :integer
      t.integer :price

      t.timestamps null: false
    end
  end
end

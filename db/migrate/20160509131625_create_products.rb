class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :title
      t.text :description
      t.integer :quaniity
      t.integer :price

      t.timestamps null: false
    end
  end
end

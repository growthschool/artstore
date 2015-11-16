class CreateProductrails < ActiveRecord::Migration
  def change
    create_table :productrails do |t|
      t.string :g
      t.string :model
      t.string :product

      t.timestamps null: false
    end
  end
end

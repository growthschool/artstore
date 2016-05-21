class CreateCartItems < ActiveRecord::Migration
  def change
    create_table :cart_items do |t|
      t.string :cart_id
      t.string :interger
      t.string :product_id
      t.string :interger

      t.timestamps null: false
    end
  end
end

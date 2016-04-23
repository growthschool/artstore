class CreateCartItems < ActiveRecord::Migration
  def change
    create_table :cart_items do |t|
      t.integer :cart_id
      t.string :product_id
      t.string :integer

      t.timestamps null: false
    end
  end
end

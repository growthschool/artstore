class AddQuantityToCartItem < ActiveRecord::Migration
  def change
    add_column :cart_items, :quantity, :integer
  end
end

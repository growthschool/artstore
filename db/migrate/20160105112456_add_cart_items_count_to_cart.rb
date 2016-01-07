class AddCartItemsCountToCart < ActiveRecord::Migration
  def change
    add_column :carts, :cart_items_count, :integer, default: 0
  end
end

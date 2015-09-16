class AddSubtotalToCartItem < ActiveRecord::Migration
  def change
    add_column :cart_items, :subtotal, :integer, default: 1
  end
end

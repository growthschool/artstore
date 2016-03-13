class AddProductToOrderItem < ActiveRecord::Migration
  def change
    add_column :order_items, :product_id, :integer
  end
end

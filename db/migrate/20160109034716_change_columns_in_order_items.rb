class ChangeColumnsInOrderItems < ActiveRecord::Migration
  def change
    remove_column :order_items, :product_id
    add_column :order_items, :product_title, :string
    add_column :order_items, :product_price, :integer
  end
end

class AddSubtotalToOrderItems < ActiveRecord::Migration
  def change
    add_column :order_items, :subtotal, :integer
  end
end

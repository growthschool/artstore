class RemoveQuantityToProducts < ActiveRecord::Migration
  def change
    change_column :products, :quantity, :integer, default: 1
    remove_column :products, :integer
  end
end

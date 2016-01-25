class AddMaxQuantityToProducts < ActiveRecord::Migration
  def change
  	add_column :products, :max_quantity , :integer, default: 0
  end
end

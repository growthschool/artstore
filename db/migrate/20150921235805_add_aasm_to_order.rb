class AddAasmToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :aasm_state, :string, default: "order_placed"
  end
end

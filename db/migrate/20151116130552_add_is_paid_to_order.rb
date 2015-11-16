class AddIsPaidToOrder < ActiveRecord::Migration
  def change
    #add_column :orders, :is_paid, :boolean, default: false
    add_column :orders, :aasm_state, :string, default: "order_placed"
    add_index  :orders, :aasm_state

  end
end

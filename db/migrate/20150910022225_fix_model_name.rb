class FixModelName < ActiveRecord::Migration
  def change
    rename_table :prodcuts, :products
  end
end

class AddTokenToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :token, :string
  end
end

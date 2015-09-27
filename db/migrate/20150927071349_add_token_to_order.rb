class AddTokenToOrder < ActiveRecord::Migration
  def change
  	def change
    add_column :orders, :token, :string
    add_index :orders, :token
  end
  end
end

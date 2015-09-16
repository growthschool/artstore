class AddTokenToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :token, :string
    add_index :orders, :token
    #加index有什麼好處？
  end
end

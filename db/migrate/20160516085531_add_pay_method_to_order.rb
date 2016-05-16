class AddPayMethodToOrder < ActiveRecord::Migration
  def change

    add_column :orders, :pay_method, :string

  end
end

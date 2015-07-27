class AddPaymentMethodToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :paymethod, :string
  end
end

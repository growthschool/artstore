class AddPaymentMethodToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :patment_method, :string
  end
end

class AddPaymentMethodToOrder < ActiveRecord::Migration
  def change
    add_column :orders , :payment_mtehod ,:string
  end
end

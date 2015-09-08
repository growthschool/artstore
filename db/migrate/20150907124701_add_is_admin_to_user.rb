class AddIsAdminToUser < ActiveRecord::Migration
  def change
   add_column :users, :is_admin, :boolean, defause: false
  end
end

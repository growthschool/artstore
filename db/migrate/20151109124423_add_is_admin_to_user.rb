class AddIsAdminToUser < ActiveRecord::Migration
  def change
    add_column :users, :is_admin, :boolean, defaut: false  # default如果是true那大家都是admin
  end
end

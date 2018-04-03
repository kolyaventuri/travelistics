class AddRoleToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :role, :smallint, default: 0
    remove_column :users, :admin
  end
end

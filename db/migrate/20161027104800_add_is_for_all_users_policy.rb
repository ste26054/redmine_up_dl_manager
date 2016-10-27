class AddIsForAllUsersPolicy < ActiveRecord::Migration
  def change
    add_column :up_dl_policies, :is_for_all_users, :boolean, default: false, :null => false
  end
end
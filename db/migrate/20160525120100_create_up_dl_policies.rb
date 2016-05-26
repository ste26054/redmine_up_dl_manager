class CreateUpDlPolicies < ActiveRecord::Migration
  def change
    create_table :up_dl_policies do |t|
      t.column :upload_policy, :integer, default: 0, :null => false
      t.column :download_policy, :integer, default: 0, :null => false
      t.column :scope_policy, :integer, default: 0, :null => false
      t.column :description, :string, :null => false
      t.column :created_at, :datetime
      t.column :updated_at, :datetime
    end

    create_table :up_dl_policy_networks do |t|
      t.belongs_to :up_dl_policy, index: true, :null => false
      t.belongs_to :up_dl_network, index: true, :null => false
    end

    create_table :up_dl_policy_users do |t|
      t.belongs_to :up_dl_policy, index: true, :null => false
      t.belongs_to :user, index: true, :null => false
    end
  end
end
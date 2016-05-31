class AddUpDlPolicyApplicability < ActiveRecord::Migration
  def change
    add_column :up_dl_policies, :applicability_policy, :integer, default: 0, :null => false
  end
end
class CreateUpDlNetworks < ActiveRecord::Migration
  def change
    create_table :up_dl_networks do |t|
      t.column :ip_list, :text, :null => false
      t.column :description, :string, :null => false
      t.column :created_at, :datetime
      t.column :updated_at, :datetime
    end
  end
end
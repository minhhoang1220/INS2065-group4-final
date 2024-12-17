class AddAdminToUsertables < ActiveRecord::Migration[7.0]
  def change
    add_column :usertables, :admin, :boolean, default: false
    add_index :usertables, :admin
  end
end 
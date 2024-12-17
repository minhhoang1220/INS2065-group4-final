class AddMembershipIdToUsertables < ActiveRecord::Migration[6.0]
  def change
    add_column :usertables, :membership_id, :integer
    add_index :usertables, :membership_id
  end
end
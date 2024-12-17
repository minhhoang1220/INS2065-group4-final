class AddUserIdToUsertables < ActiveRecord::Migration[7.0]
  def change
    add_column :usertables, :user_id, :integer
  end
end

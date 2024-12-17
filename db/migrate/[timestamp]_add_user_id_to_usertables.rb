class AddUserIdToUsertables < ActiveRecord::Migration[7.0]
  def change
    add_reference :usertables, :user, foreign_key: true, null: true
    add_index :usertables, :user_id, unique: true
  end
end 
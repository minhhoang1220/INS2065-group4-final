class ChangeActiveTypeInUsertables < ActiveRecord::Migration[7.0]
  def up
    change_column :usertables, :active, :boolean, 
      using: "CASE WHEN active = 'true' THEN true ELSE false END",
      default: true
  end

  def down
    change_column :usertables, :active, :string
  end
end
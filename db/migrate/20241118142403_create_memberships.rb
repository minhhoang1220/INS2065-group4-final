class CreateMemberships < ActiveRecord::Migration[7.0]
  def change
    create_table :memberships do |t|
      t.string :TypeMem
      t.decimal :price
      t.text :description

      t.timestamps
    end
  end
end

class CreateUsertables < ActiveRecord::Migration[7.0]
  def change
    create_table :usertables do |t|
      t.string :TypeMem
      t.string :name
      t.string :email
      t.string :password
      t.string :active
      t.integer :age
      t.string :gender
      t.string :image
      t.text :bio

      t.timestamps
    end
  end
end

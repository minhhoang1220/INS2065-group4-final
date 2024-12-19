class CreateUsertables < ActiveRecord::Migration[7.0]
  def change
    create_table :usertables do |t|
      t.string :TypeMem
      t.string :name
      t.string :email
      t.string :password
      t.boolean :active, default: true
      t.integer :age
      t.string :gender
      t.text :bio

      t.timestamps
    end
  end
end

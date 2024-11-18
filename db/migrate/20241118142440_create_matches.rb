class CreateMatches < ActiveRecord::Migration[7.0]
  def change
    create_table :matches do |t|
      t.integer :User1ID
      t.integer :User2ID
      t.timestamp :MatchTimestamp

      t.timestamps
    end
  end
end

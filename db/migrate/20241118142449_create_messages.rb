class CreateMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :messages do |t|
      t.integer :matchID
      t.integer :senderID
      t.integer :receiverID
      t.text :messageText
      t.timestamp :messageTimestamp

      t.timestamps
    end
  end
end

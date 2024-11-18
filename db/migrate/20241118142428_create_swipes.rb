class CreateSwipes < ActiveRecord::Migration[7.0]
  def change
    create_table :swipes do |t|
      t.integer :SwiperUserID
      t.integer :SwipedUserID
      t.string :SwipeType
      t.timestamp :SwipeTimestamp

      t.timestamps
    end
  end
end

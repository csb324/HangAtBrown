class AddIndexesEverywheree < ActiveRecord::Migration
  def change
    add_index :events, :creator_id
    add_index :interests, :user_id
    add_index :rsvps, :user_id
    add_index :rsvps, :event_id
  end
end

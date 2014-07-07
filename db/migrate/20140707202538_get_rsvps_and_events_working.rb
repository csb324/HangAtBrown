class GetRsvpsAndEventsWorking < ActiveRecord::Migration
  def change
    add_column :rsvps, :creator, :boolean, default: false
    remove_reference :events, :creator
  end
end

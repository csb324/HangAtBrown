class CreateRsvPs < ActiveRecord::Migration
  def change
    create_table :rsvps do |t|
      t.references :user, null: false
      t.references :event, null: false
      t.datetime :expected_arrival, null: false
      t.text :outfit, null: false
    end
  end
end

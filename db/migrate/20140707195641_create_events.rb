class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.references :location, index: true
      t.datetime :start_time, null: false
      t.datetime :end_time, null: false
      t.text :topic
    end
  end
end

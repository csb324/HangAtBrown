class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.text :name, null: false
      t.text :description, null: false
      t.text :url, null: false
    end
  end
end

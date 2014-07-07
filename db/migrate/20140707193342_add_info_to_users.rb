class AddInfoToUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.text :first_name, null: false
      t.text :last_name, null: false
      t.string :phone_number, null: false
      t.text :class_year, null: false
      t.text :concentration, null: false, default: "Undecided"
    end
  end
end

class AddInterestsToUser < ActiveRecord::Migration
  def up
    drop_table :interests
    add_column :users, :interests, :string, array: true, default: '{}'
  end

  def down
    create_table :interests do |t|
      t.references :user
      t.text :name
    end
    drop_column :users, :interests
  end

end

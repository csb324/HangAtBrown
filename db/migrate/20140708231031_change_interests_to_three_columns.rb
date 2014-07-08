class ChangeInterestsToThreeColumns < ActiveRecord::Migration
  def change

    remove_column :users, :interests, :string, array: true, default: '{}'
    add_column :users, :interest_one, :text
    add_column :users, :interest_two, :text
    add_column :users, :interest_three, :text

  end
end

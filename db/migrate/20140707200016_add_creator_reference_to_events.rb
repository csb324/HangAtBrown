class AddCreatorReferenceToEvents < ActiveRecord::Migration
  def change
    add_reference :events, :creator, references: :users
  end
end

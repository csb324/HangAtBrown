class Rsvp < ActiveRecord::Base

  belongs_to :user
  belongs_to :event

  validates! :user, :event, presence: true
  validates :expected_arrival, :outfit, presence: true

end

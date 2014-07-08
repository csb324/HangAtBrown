class Event < ActiveRecord::Base

  TYPES = ["eat", "have coffee", "study", "read", "write"]

  belongs_to :location

  has_many :rsvps, dependent: :destroy
  has_many :users, through: :rsvps

  accepts_nested_attributes_for :rsvps

  #validates :event_type, inclusion:{ in: TYPES }

  def host
    rsvps.select{ |rsvp| rsvp.creator == true }.first.user
  end

end

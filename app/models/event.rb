class Event < ActiveRecord::Base

  TYPES = ["eat", "have coffee", "study", "read", "write"]

  belongs_to :location

  has_many :rsvps, dependent: :destroy
  has_many :users, through: :rsvps

  accepts_nested_attributes_for :rsvps
  validates_associated :rsvps

  validates :event_type, inclusion:{ in: TYPES }

  validate :start_time_cannot_be_in_the_past

  def start_time_cannot_be_in_the_past
    if start_time < Time.now
      errors.add(:start_time, "can't be in the past")
    end
  end

  def host
    rsvps.select{ |rsvp| rsvp.creator == true }.first.user
  end

end

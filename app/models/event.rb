class Event < ActiveRecord::Base

  TYPES = ["eat", "have coffee", "study", "read", "write"]

  belongs_to :location

  has_many :rsvps
  has_many :users, through: :rsvps

  accepts_nested_attributes_for :rsvps
  validates_associated :rsvps

  validates :event_type, inclusion:{ in: TYPES }

  validate :start_time_cannot_be_in_the_past
  validate :start_time_cannot_be_after_end_time

  def start_time_cannot_be_in_the_past
    if start_time < Time.now
      errors.add(:start_time, "can't be in the past")
    end
  end

  def start_time_cannot_be_after_end_time
    if start_time > end_time
      errors.add(:end_time, "can't be before start time")
    end
  end

  def host
    rsvps.select{ |rsvp| rsvp.creator == true }.first.user
  end

  def subjects
    if topic.present?
      [topic]
    else
       host.all_interests
    end
  end
  private

end

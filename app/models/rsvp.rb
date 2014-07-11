class Rsvp < ActiveRecord::Base

  COLORS = %w(black grey white cream brown red orange yellow green blue purple pink silver gold striped patterned neon)
  OBJECTS = %w(t-shirt button-down hat backpack jacket scarf tie headband headphones sweater cardigan blazer)

  attr_accessor :outfit_color, :outfit_object

  include ApplicationHelper

  belongs_to :user
  belongs_to :event

  # If there's no user, something is seriously wrong.
  validates! :user, :event, presence: true

  # User should definitely input these fields
  validates :expected_arrival, :outfit, presence: true

  # You can't rsvp to an event that you've already rsvp-ed to, silly
  validates :user, uniqueness: { scope: :event, message: ": You are already hanging out here!" }

  validate :expected_arrival_must_be_during_event
  validate :expected_arrival_cannot_be_in_the_past
  validate :event_does_not_already_have_host

  def event_does_not_already_have_host
    if creator == true && event.all_hosting_rsvps.length > 1
      errors.add(:user, "cannot host an event that already exists")
    end
  end

  def expected_arrival_must_be_during_event
    if event.start_time > expected_arrival
      errors.add(:expected_arrival, "can't be before the hang begins")
    elsif event.end_time < expected_arrival
      errors.add(:expected_arrival, "can't be after the hang ends")
    end
  end

  def expected_arrival_cannot_be_in_the_past
    if expected_arrival < Time.now
      errors.add(:expected_arrival, "can't be in the past")
    end
  end

  # Convenience for time formatting
  def arrival_time_name
    nice_time(expected_arrival)
  end

end

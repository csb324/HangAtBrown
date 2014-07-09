class Rsvp < ActiveRecord::Base

  belongs_to :user
  belongs_to :event

  validates! :user, :event, presence: true
  validates :expected_arrival, :outfit, presence: true

  validates :expected_arrival_must_be_during_event

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

  validates :user, uniqueness: { scope: :event, message: ": You are already hanging out here!" }
end

class Event < ActiveRecord::Base

  # This has my time formatter
  include ApplicationHelper

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

  def all_hosting_rsvps
    rsvps.select{ |rsvp| rsvp.creator == true }
  end

  # There should only ever be one person in this array.
  def host
    all_hosting_rsvps.first.user
  end

  # How much of the host's name should show, based on the viewer's RSVP status
  def host_nickname(currentuser)
    if users.include? currentuser
      host.first_name
    else
      host.first_name.first + "." + host.last_name.first + "."
    end
  end

  def event_description(currentuser)
    description = event_type  # "Eat" // "Study"
    if event_type == "study"
      description += " "      # "study "
    else
      description += " and talk about " # "eat and talk about "
    end
    description += subjects.sample      # "eat and talk about politics" // "study economics"
    description += " with "
    if currentuser == host
      other_people = users.count - 1
      description += "#{other_people} other people (so far!)"
    else
      description += host_nickname(currentuser)
    end
  end

  # Time-saver
  def host_outfit
    rsvps.select{ |rsvp| rsvp.creator == true }.first.outfit
  end

  # If the host defined a topic, subject is topic
  def subjects
    if topic.present?
      [topic]
    else
      # Otherwise, subject is all of the host's interests
      host.all_interests
    end
  end

  # true/false - Is this event currently happening?
  def current?
    has_started = start_time < Time.now
    has_not_ended = end_time > Time.now
    has_started && has_not_ended
  end

  # Is the event in the past?
  def past?
    end_time < Time.now
  end

  # Time name formatting (for convenience)
  def start_time_name
    nice_time(start_time)
  end

  def end_time_name
    nice_time(end_time)
  end

  private

end

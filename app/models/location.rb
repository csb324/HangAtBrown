class Location < ActiveRecord::Base
  has_many :events, dependent: :destroy
  validates! :name, presence: true

  # Array of all events in this location that are currently happening
  def current_events
    events.select do |event|
      event.current?
    end
  end

  # Array of all events in this location that have not started yet
  def future_events
    events.select do |event|
      event.start_time > Time.now
    end
  end

  # Array of all events that have happened between some-time-ago and now
  def events_since(time)
    range_begin = Time.now - time
    events.select do |event|
      event.start_time > range_begin && event.start_time < Time.now
    end
  end
end

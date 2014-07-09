class Location < ActiveRecord::Base
  has_many :events, dependent: :destroy
  validates! :name, presence: true

  def current_events
    events.select do |event|
      has_started = event.start_time < Time.now
      has_not_ended = event.end_time > Time.now
      has_started && has_not_ended
    end
  end

end

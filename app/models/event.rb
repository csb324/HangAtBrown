class Event < ActiveRecord::Base

  belongs_to :location

  has_many :rsvps, dependent: :destroy
  has_many :users, through: :rsvps

  def host
    rsvps.select{ |rsvp| rsvp.creator == true }.first.user
  end

end

class Event < ActiveRecord::Base

  belongs_to :location

  has_many :rsvps, dependent: :destroy
  has_many :users, through: :rsvps

end

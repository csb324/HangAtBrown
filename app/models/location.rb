class Location < ActiveRecord::Base
  has_many :events, dependent: :destroy
  validates! :name, presence: true
end

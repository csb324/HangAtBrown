class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  CLASS_YEARS = ["First year", "Sophomore", "Junior", "Senior", "Grad Student", "Alum", "Faculty"]

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :events, through: :rsvps
  has_many :rsvps, dependent: :destroy

  validates :first_name, :last_name, :email, :phone_number, presence: true
  validates :class_year, inclusion: {in: CLASS_YEARS}

  def all_interests
    [interest_one.downcase, interest_two.downcase, interest_three.downcase]
  end

  def upcoming_events
    events.select{ |event| !event.past }
  end

end

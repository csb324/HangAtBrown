class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :events, through: :rsvps
  has_many :rsvps, dependent: :destroy

  validates :first_name, :last_name, :email, :class_year, :concentration, presence: true

  def all_interests
    [interest_one.downcase, interest_two.downcase, interest_three.downcase]
  end

end

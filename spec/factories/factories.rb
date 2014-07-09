FactoryGirl.define do

  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { rand(1000).to_s << "@brown.edu"}
    password "spicywith"
    phone_number { Faker::PhoneNumber.phone_number }
    class_year "Alum"
    interest_one "brunonia"
    interest_two "psychoceramics"
    interest_three "the meaning of life"
  end

  factory :event do
    location { Location.all.sample }
    start_time Time.now + 30.minutes
    end_time Time.now + 3.hours
    event_type "have coffee"

    factory :event_with_host do
      ignore do
        user { User.all.sample }
      end

      after(:create) do |event, evaluator|
        event.rsvps << create(:rsvp, event: event, user: evaluator.user, creator: true)
      end
    end

  end

  factory :location do
    name { ["The Blue Room", "The Rock", "The Scili", "The Ratty", "Andrews Dining Hall", "The VDub", "Jo's", "Faunce Steps", "The Bookstore", "Tealuxe", "Starbucks", "Granoff"].sample }
    description "abcdefghijklmn i don't care i love it da da da"
    url { ["https://s.yimg.com/pw/images/spaceout.gif", "https://s.yimg.com/pw/images/spaceout.gif", "https://s.yimg.com/pw/images/spaceout.gif", "https://s.yimg.com/pw/images/spaceout.gif"].sample }
  end

  factory :rsvp do
    user
    event
    expected_arrival Time.now + 2.hours
    outfit "Kberg Cape"
    creator false
  end

end

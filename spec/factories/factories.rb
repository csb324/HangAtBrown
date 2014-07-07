FactoryGirl.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email "josiah_carburry@brown.edu"
    password "spicywith"
    phone_number { Faker::PhoneNumber.phone_number }
    class_year "Alumni"
  end

  factory :event do
    location { Location.all.sample }
    start_time Time.now + 2.hours
    end_time (Time.now + 3.hours)
  end

  factory :location do
    name { ["The Blue Room", "The Rock", "The Scili", "The Ratty", "Andrews Dining Hall", "The VDub", "Jo's", "Faunce Steps", "The Bookstore", "Tealuxe", "Starbucks", "Granoff"].sample }
    description "abcdefghijklmn i don't care i love it da da da"
    url { ["https://s.yimg.com/pw/images/spaceout.gif", "https://s.yimg.com/pw/images/spaceout.gif", "https://s.yimg.com/pw/images/spaceout.gif", "https://s.yimg.com/pw/images/spaceout.gif"].sample }
  end

end

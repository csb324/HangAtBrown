FactoryGirl.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email "josiah_carburry@brown.edu"
    password "spicywith"
    phone_number { Faker::PhoneNumber.phone_number }
    class_year "Alumni"
  end
end

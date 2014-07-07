# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


Location.delete_all
Event.delete_all
Interest.delete_all
Rsvp.delete_all

Location.create!(name: "The Ratty", description: "That big dining hall on Wriston. Come on, how new here are you?", url: "http://www.browndailyherald.com/wp-content/uploads/2012/12/2269267368.jpg")
Location.create!(name: "The Blue Room", description: "Muffins. Sandwiches. Kabob & Curry.", url: "http://www.brown.edu/campus-life/support/campus-center//sites/brown.edu.campus-life.support.campus-center/files/images/Blue%20Room.ursa-feature-image.JPG")

User.create!(email: "josiah_carburry@brown.edu", password: "spicywith", first_name: "Josiah", last_name: "Carburry", phone_number: "7034733719", class_year: "Alumni")

Event.create!(location: Location.find_by_name("The Ratty"), start_time: Time.now, end_time: Time.now + 1.hour)
Rsvp.create!(user: User.first, event: Event.first, expected_arrival: Time.now + 10.minutes, outfit: "red hat", creator: true)

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


Location.delete_all
Event.delete_all
Rsvp.delete_all

FactoryGirl.create(:location, name: "The Ratty", url: "ratty.jpg")
FactoryGirl.create(:location, name: "The SciLi Basement", url: "scili-basement.jpg")
FactoryGirl.create(:location, name: "The Blue Room", url: "blue-room.jpg")
FactoryGirl.create(:location, name: "Jo's", url: "jos.jpg")
FactoryGirl.create(:location, name: "The Rock", url: "rock.jpg")
FactoryGirl.create(:location, name: "The SciLi 3rd Floor", url: "scili-3.jpg")
FactoryGirl.create(:location, name: "The Ivy Room", url: "ivy-room.jpg")

FactoryGirl.create_list(:user, 10)

FactoryGirl.create_list(:event_with_host, 5)

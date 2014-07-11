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

Location.new(name: "The Ratty", url: "ratty.jpg")
Location.new(name: "The SciLi Basement", url: "scili-basement.jpg")
Location.new(name: "The Blue Room", url: "blue-room.jpg")
Location.new(name: "Jo's", url: "jos.jpg")
Location.new(name: "The Rock", url: "rock.jpg")
Location.new(name: "The SciLi 3rd Floor", url: "scili-3.jpg")
Location.new(name: "The Ivy Room", url: "ivy-room.jpg")


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

Location.create(name: "The Ratty", url: "ratty.jpg", description: "Otherwise known as the Sharpe Refectory. Otherwise known as the biggest dining hall on campus.")
Location.create(name: "The SciLi Basement", url: "scili-basement.jpg", description: "The Friedman Study Center is a great place to hang, if you're cool with staying under the decibel limit")
Location.create(name: "The Blue Room", url: "blue-room.jpg", description: "Home of delicious muffins and very overpriced sushi")
Location.create(name: "Jo's", url: "jos.jpg", description: "How many times have you wanted a quesadilla but couldn't convince anyone else to come with you?")
Location.create(name: "The Rock", url: "rock.jpg", description: "The John D. Rockefeller Library. Once upon a time, Brown students used to call this building the John. #truefact")
Location.create(name: "The SciLi 3rd Floor", url: "scili-3.jpg", description: "The science center is pretty cool I guess.")
Location.create(name: "The Ivy Room", url: "ivy-room.jpg", description: "Go falafel or go home.")
Location.create(name: "The VDub", url: "vdub.jpg", description: "The dining hall of choice for Pembroke residents and people who like waffles")
Location.create(name: "Starbucks", url: "starbucks.jpg", description: "If you like Starbucks I'm not going to judge you.")
Location.create(name: "Bookstore Blue State", url: "bookstore.jpg", description: "That little Blue State inside the Brown Bookstore has a pretty wicked grilled cheese sandwich.")

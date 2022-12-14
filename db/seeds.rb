# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require 'faker'

LoginInvitation.delete_all
User.destroy_all
Room.destroy_all

5.times do 
  User.create(email: Faker::Internet.unique.email)
end

room_one = Room.create(name: "Fun Room")
room_two = Room.create(name: "Sad Room")

10.times do
  user = User.all.sample
  message = user.messages.build(description: Faker::Quote.famous_last_words)
  room_one.messages << message
end

10.times do
  user = User.all.sample
  message = user.messages.build(description: Faker::Quote.famous_last_words)
  room_two.messages << message
end

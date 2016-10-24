# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(name: "Chris Norwood",
             email: "cnorwood92@gmail.com",
             password: "foobar",
             password_confirmation: "foobar")

User.create!(name: "Dan Norwood",
             email: "dan@spectreair.com",
             password: "foobar",
             password_confirmation: "foobar")

25.times do |n|
  name  = Faker::Name.name
  email = "example-#{n}@odinbook.com"
  password = "foobar"
  User.create!(name: name, email: email, password: password, password_confirmation: password)
end

# Posts
me = User.first
10.times do |n|
  body = Faker::Lorem.sentence(6)
  me.posts.create!(body: body)
end

dan = User.second
10.times do |n|
  body = Faker::Lorem.sentence(6)
  dan.posts.create!(body: body)
end

5.times do |n|
  body = Faker::Lorem.sentence(2)
  me.posts.first.comments.create!(body: body, user: dan)
end

5.times do |n|
  body = Faker::Lorem.sentence(2)
  dan.posts.first.comments.create!(body: body, user: me)
end

# users = User.order(:created_at).take(6)
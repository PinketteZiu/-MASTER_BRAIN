# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'faker'

20.times do
  User.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.email, password: Faker::Name.name)
end

10.times do
  Brain.create!(name: Faker::Cannabis.cannabinoid, price: Faker::Number.number, address: Faker::Address.city, latitude: Faker::Address.latitude, longitude: Faker::Address.longitude, user: User.all.sample)
end

10.times do
  Booking.create!(confirmation: false, user: rand(1..25), brain_id: rand(1..10))
end

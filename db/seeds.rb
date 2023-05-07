# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require 'faker'

# Destroy all the databases
User.destroy_all
City.destroy_all
Reservation.destroy_all
Accomodation.destroy_all

# Create 20 users

20.times do
  User.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.email, phone_number: Faker::PhoneNumber.phone_number, description: Faker::Lorem.paragraph)
end

# Create 10 towns

10.times do
  City.create!(name: Faker::Address.city, zip_code: Faker::Address.zip_code)
end

# Create 50 accomodations

50.times do
  Accomodation.create!(available_beds: Faker::Number.within(range: 1..4),price: Faker::Number.within(range: 50..150), description: Faker::Lorem.paragraph_by_chars(number: 140, supplemental: false), has_wifi: Faker::Boolean.boolean, welcome_message: Faker::Lorem.paragraph(sentence_count: 2), city_id: City.all.sample.id, administrator_id: User.all.sample.id)
end

# Create 5 reservations in the past

5.times do
  start_date = Faker::Date.between(from: 2.year.ago, to: Date.today - 1)
  end_date = Faker::Date.between(from: start_date + 1.day, to: Date.today)
  Reservation.create!(start_date: start_date, end_date: end_date, guest_id: User.all.sample.id, accomodation_id: Accomodation.all.sample.id)
end

# Create 5 reservations in the futur

5.times do
  start_date = Faker::Date.between(from: Date.today + 1.day, to: 2.years.since)
  end_date = Faker::Date.between(from: start_date + 1.day, to: 2.years.since + 1)
  Reservation.create!(start_date: start_date, end_date: end_date, guest_id: User.all.sample.id, accomodation_id: Accomodation.all.sample.id)
end
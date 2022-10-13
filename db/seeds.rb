# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'faker'
users = []
users << User.create!(email: 'test@test.com', password: 'aassdd123', password_confirmation: 'aassdd123')
users << User.create!(email: 'admin@test.com', password: 'aassdd123', password_confirmation: 'aassdd123')

users.each do |user|
  4.times.each do
    user.todos.create!(title: Faker::Lorem.question, content: Faker::Lorem.paragraph)
  end
end

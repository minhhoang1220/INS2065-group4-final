# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Create default memberships
Membership.create([
  { TypeMem: 'Basic', price: 9.99, description: 'Basic membership with limited features.' },
  { TypeMem: 'Gold+', price: 19.99, description: 'Gold+ membership with additional features.' },
  { TypeMem: 'Premium', price: 29.99, description: 'Premium membership with all features included.' }
])

puts "Default memberships created!"
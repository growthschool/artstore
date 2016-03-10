# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
puts "Add user 'admin@test.com'"

u = User.new
u.email = 'admin@test.com'
u.password = '12345678'
u.password_confirmation = '12345678'
u.is_admin = true
u.save

puts "Add products"

Product.create([title: 'iMac', description: 'Desktop', quantity: 100, price: 80000])
Product.create([title: 'iPad', description: 'Tablet', quantity: 200, price: 16000])
Product.create([title: 'iPhone', description: 'Smart Phone', quantity: 300, price: 30000])

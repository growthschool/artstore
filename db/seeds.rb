# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

u = User.new
u.email = "admin@test.com"
u.password = "12345678"
u.password_confirmation = "12345678"
u.is_admin = true
u.save

u = User.new
u.email = "user1@test.com"
u.password = "12345678"
u.password_confirmation = "12345678"
u.is_admin = false
u.save

u = User.new
u.email = "jrubyuncle@gmail.com"
u.password = "12345678"
u.password_confirmation = "12345678"
u.is_admin = false
u.save

for i in 1..10 do
  User.create(
      email: "demo_user_#{i}@seed.com",
      password: "12345678",
      password_confirmation: "12345678"
    )
end

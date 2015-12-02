# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
for i in 1..10 do
    normal_user = User.create(email: "user_#{i}@test.com", password: "12345678",
                       password_confirmation: "12345678" )
  end


  admin_user = User.new
  admin_user.email = "admin@test.com"
  admin_user.password = "12345678"
  admin_user.password_confirmation = "12345678"
  admin_user.is_admin = true
  admin_user.save

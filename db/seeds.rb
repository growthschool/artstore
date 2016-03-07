# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

adminUser = User.new
adminUser.email = "admin@gmail.com"
adminUser.password = "11111111"
adminUser.password_confirmation = "11111111"
adminUser.is_admin = true
adminUser.save

normalUser = User.new
normalUser.email = "user@gmail.com"
normalUser.password = "11111111"
normalUser.password_confirmation = "11111111"
normalUser.is_admin = false
normalUser.save

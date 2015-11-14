# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:


u = User.new
u.email = "multe.chang@gmail.com"
u.password = "11111111"
u.password_confirmation = "11111111"
u.is_admin = true
u.save

#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

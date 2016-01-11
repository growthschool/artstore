# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

u = User.new
u.email = "ss@ss.com"
u.password = "12341234"
u.password_confirmation = "12341234"
u.is_admin = true
u.save

u = User.new
u.email = "dd@dd.com"
u.password = "12341234"
u.password_confirmation = "12341234"
u.is_admin = true
u.save

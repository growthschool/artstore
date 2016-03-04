# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


u = User.new
u.email = "clc0330@gmail.com"
u.password = "wowcool14"
u.password_confirmation = "wowcool14"
u.is_admin = true
u.save

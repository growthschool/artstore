# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

create_products = for index in 1..10 do
	product = Product.create(
		name = "demo product ##{i}",
		quantity = 200,
		price = 100 * i
	)
end

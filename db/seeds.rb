# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# puts "Hello World!"

# u = User.new(:email=> "xxx@xxx.com", :password => "12345678", :password_confirmation => "12345678")
# create_account = User.create([email: 'example@gmail.com', password: '12345678', password_confirmation: '12345678', name: '測試用帳號'])

# single admin user
# create_account = User.create([email: 'example@gmail.com', password: '12345678', password_confirmation: '12345678', is_admin: true])

# create user
create_groups = for i in 1..10 do
  User.create!([email: "example#{i}@gmail.com", password: '12345678', password_confirmation: '12345678', is_admin: true])
  puts "example#{i}@gmail.com user created"
  # create item
  # for k in 1..10 do
  # Product.create!([title: "貨品#{i}", description: "第#{i}個物品", quantity: 1, price: 100*i])
  # end
end

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

create_users = for i in 1..10 do
  user = User.create(
    email: "demo_user_#{i}@test.com",
    password: "12345678", 
    password_confirmation: "12345678"
    )
end

admin_user = User.create(
    email: "admin@test.com",
    password: "12345678", 
    password_confirmation: "12345678",
    is_admin: true
    )

# 建立二筆商品資料

product = Product.new
product.title = "macbook"
product.price = "60000"
product.quantity = "5"
product.description = "蘋果電腦"
product.save

product.build_photo.save
product.photo.image.store!(File.open(File.join(Rails.root, 'public/macbook.jpg')))
product.photo.save!


product2 = Product.new
product2.title = "iphone"
product2.price = "20000"
product2.quantity = "5"
product2.description = "蘋果手機"
product2.save

product2.build_photo.save
product2.photo.image.store!(File.open(File.join(Rails.root, 'public/iphone.jpg')))
product2.photo.save!

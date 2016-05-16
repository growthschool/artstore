# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

u = User.new

u.email = "admin@test.com"           # 可以改成自己的 email
u.password = "12345678"              # 最少要八碼
u.password_confirmation = "12345678" # 最少要八碼

u.is_admin = true
u.save

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

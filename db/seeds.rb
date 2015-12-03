# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# 將初始的種子資料，於deploy server後自動產生 , 再修改內容

# 建立一個預設有管理者權限的帳號
u = User.new
u.email = "admin@test.com"
u.password = "12345678"
u.password_confirmation = "12345678"
u.is_admin = true
u.save

# 建立10個預設使用者帳號
create_users = for i in 1..10 do
  user = User.create(
    email: "demo_user_#{i}@test.com",
    password: "12345678",
    password_confirmation: "12345678"
    )
end



if User.all.count() == 0
  puts "添加管理者帳號"
  User.create(email: 'admin@admin.com', password: 'admin', password_confirmation: 'admin', is_admin: true)
end

u = User.new
u.email = "admin@test.com"           # 可以改成自己的 email
u.password = "12345678"              # 最少要八碼
u.password_confirmation = "12345678" # 最少要八碼
u.is_admin = true
u.save
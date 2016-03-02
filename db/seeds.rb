u = User.new
u.email = "ouyangyi0831@gmail.com"           # 可以改成自己的 email

u.password = "0uyangy1"              # 最少要八碼

u.password_confirmation = "0uyangy1" # 最少要八碼

u.is_admin = true
u.save
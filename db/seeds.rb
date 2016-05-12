p "Create two users, one with admin right, the other not..."
u1 = User.new(email: "a@a.com", password: "12341234", password_confirmation: "12341234", is_admin: true)
u2 = User.new(email: "b@b.com", password: "12341234", password_confirmation: "12341234", is_admin: false)
u1.save!
u2.save!
p "Users created."

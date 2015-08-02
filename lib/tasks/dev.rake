namespace :dev do
  # ... (上略)
   
  desc "建立 10 個 User 帳號"
  task :users => :environment do
    for i in 1..10 do
      user = User.create(
        email: "demo_user_#{i}@test.com",
        password: "12345678", 
        password_confirmation: "12345678"
        )
    end
  end
end
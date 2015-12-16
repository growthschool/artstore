namespace :dev do  
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

namespace :dev do
  desc "Clear tmp, database and re-run all migrations and db:seed"
  task rebuild: [ "tmp:clear", "log:clear", 
                  "db:drop", "db:create", 
                  "db:migrate", "db:seed" ]
end
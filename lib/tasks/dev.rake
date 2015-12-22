namespace :dev do

  desc "rebuild system"
  task :build =>["tmp:clear", "log:clear", "db:drop", "db:create", "db:migrate", "db:seed" ]

  desc "demo"
  # environment 會載入整個專案 ，如果沒有寫，代表只是ruby語言,執行某個東西
  task :demo => :environment do
    for i in 1..10 do
      Catagory.create!(:name => "Category #{n}")
    end
  end

  desc "Clear tmp, database and re-run all migrations and db:seed"
  task rebuild: [ "tmp:clear", "log:clear", "db:drop", "db:create", "db:migrate", "dev:build", "db:seed" ]

  desc "建立十個使用者名稱"
  task :users => :environment do
    for i in 1..10 do
      user.User.create(
        email: "demo_user_#{i}@test.com",
        password: "12345678",
        password_confirmation: "12345678"
        )
    end
  end
end

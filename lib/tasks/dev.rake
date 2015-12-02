namespace :dev do
  desc "建立十個user帳號"
  task :users => :environment do
    for i in 1..10 do
      user = User.create(email: "user_#{i}@test.com", password: "12345678",
                        password_confirmation: "12345678" )
    end
  end

  desc "clear tmp, database and re-run migrations and db:seed"
  task rebuild: ["tmp:clear", "log:clear", "db:drop", "db:create", "db:migrate", "db:seed"]


end

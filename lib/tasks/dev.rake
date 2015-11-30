namespace :dev do

  desc "rebuild system"
  task :build =>["tmp:clear", "log:clear", "db:drop", "db:create", "db:migrate", "db:seed" ]

  desc "demo"
  task :demo => :environment do
    for i in 1..10 do
      Catagory.create!(:name => "Category #{n}")
    end
  end
end

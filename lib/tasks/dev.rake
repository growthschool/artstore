namespace :dev do
  desc "clear tmp, database and re-run all migration and db:seed"
  task rebuild: ["tmp:clear", "log:clear", "db:drop", "db:create", "db:migrate", "db:seed"]
end

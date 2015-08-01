namespace :dev do
  desc "清理暫存檔，重置資料庫"
  task rebuild: ["tmp:clear", "log:clear", "db:drop", "db:create", "db:migrate", "db:seed"]
end

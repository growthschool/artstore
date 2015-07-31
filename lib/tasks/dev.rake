# 自動化執行清空＋重跑migration+種子載入資料

namespace :dev do

  desc "Clear tmp, database and re-run all migrations and db:seed"

  task :rebuild => ["tmp:clear", ":log:clear",
                    "db:drop", "db:create",
                    "db:migrate", "db:test:prepare", "db:seed"]  
end
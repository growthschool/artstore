namespace :dev do

	desc "Clear tmp, database and re-run all migrations and db:seed"
	task rebuild: ["tmp:clear","log:clear","db:drop","db:create","db:migrate","db:seed"]
end
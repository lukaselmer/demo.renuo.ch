# required to be able to run rake db:drop because otherwise the db is locked due to being accessed by another process
# use rake db:drop db:create db:migrate && rake db:seed to savely reset your dev env
# @see http://stackoverflow.com/questions/2369744/rails-postgres-drop-error-database-is-being-accessed-by-other-users
task :kill_postgres_connections => :environment do
  db_name = "#{File.basename(Rails.root)}_#{Rails.env}"
  sh = <<EOF
ps xa \
  | grep postgres: \
  | grep #{db_name} \
  | grep -v grep \
  | awk '{print $1}' \
  | xargs kill
EOF
  puts `#{sh}`
end

task 'db:drop' => :kill_postgres_connections
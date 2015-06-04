DUMP_PATH = "/tmp/remit_prod_db.dump"
GIT_REMOTE = "heroku"  # Must specify explicitly since I have more than one.

namespace :dev do
  desc "Reset development database from a production dump"
  task :db => [ :dump_db, :download_db, :import_db, :"db:migrate" ] do
    puts "Done!"
  end

  task :dump_db do
    system("heroku pg:backups capture --remote #{GIT_REMOTE}") || exit(1)
  end

  # https://devcenter.heroku.com/articles/heroku-postgres-import-export
  task :download_db do
    system("curl", "--output", DUMP_PATH, `heroku pg:backups public-url --remote #{GIT_REMOTE}`.chomp) || exit(1)
  end

  task :import_db => [ :"db:drop", :"db:create" ] do
    if ENV["DEVBOX"]
      system(%{PGPASSWORD=dev pg_restore --no-acl --no-owner -d remit_development --username postgres --host localhost --port $(service_port postgres) "#{DUMP_PATH}"}) || exit(1)
    else
      system(%{pg_restore --no-acl --no-owner -d remit_development "#{DUMP_PATH}"}) || exit(1)
    end
  end
end

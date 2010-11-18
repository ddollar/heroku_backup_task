require "heroku_backup_task"

task :heroku_backup do
  HerokuBackupTask.execute
end

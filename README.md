# heroku\_backup\_task

## Description

A simple helper to automate your [Heroku](http://heroku.com) app [backups](http://addons.heroku.com/pgbackups)

## Installation

    # Gemfile
    gem "heroku_backup_task"

    # Rakefile
    require "heroku_backup_task/tasks"
    task :cron => :heroku_backup

    # Rakefile (alternative)
    require "heroku_backup_task"
    task :cron do
      # other code here
      HerokuBackupTask.execute
    end

Make sure you install the pgbackups addon

    heroku addons:add pgbackups:basic

## Configuration

By default, `heroku_backup_task` will back up `DATABASE_URL`. You can change this with:

    heroku config:add HEROKU_BACKUP_DATABASES="SOME_DATABASE_URL,OTHER_DATABASE_URL"
    
## Usage

### NOTE: `heroku_backup_task` will expire your oldest backup to make room for a new backup if necessary.

Set up cron on your application with

    heroku addons:add cron:daily

You will see something like this in your cron logs

    [Thu Nov 18 12:59:56 -0500 2010] starting heroku backup task
    [Thu Nov 18 12:59:57 -0500 2010] backing up: DATABASE_URL

## License

MIT

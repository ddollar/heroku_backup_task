# heroku\_backup\_task

## Description

A simple helper to automate your [Heroku](http://heroku.com) app [backups](http://addons.heroku.com/pgbackups)

## Installation

    # Gemfile
    gem "heroku_backup_task"

    # Rakefile
    task :cron => :heroku_backup

    # Rakefile (alternative)
    task :cron do
      # other code here
      HerokuBackupTask.execute
    end

Make sure you install the pgbackups addon

    heroku addons:add pgbackups:basic

## Configuration

By default, `heroku_backup_task` will back up `DATABASE_URL` and will keep
a maximum of 2 backups. You can change these defaults:

    heroku config:add HEROKU_BACKUP_DATABASES="SOME_DATABASE_URL,OTHER_DATABASE_URL"
    heroku config:add HEROKU_BACKUP_MAXBACKUPS=7
    
Make sure that `HEROKU_BACKUP_MAXBACKUPS` is less than or equal to the number
of backups supported by your pgbackups plan.

## Usage

Set up cron on your application with

    heroku addons:add cron:daily

You will see something like this in your cron logs

    [Thu Nov 18 12:59:56 -0500 2010] starting heroku backup task
    [Thu Nov 18 12:59:56 -0500 2010] too many backups (2 max), purging 1 to make room
    [Thu Nov 18 12:59:56 -0500 2010]   removing b007
    [Thu Nov 18 12:59:57 -0500 2010] backing up: DATABASE_URL

## License

MIT

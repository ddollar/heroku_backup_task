require "heroku"
require "pgbackups/client"

module HerokuBackupTask; class << self

  def log(message)
    puts "[#{Time.now}] #{message}"
  end

  def backups_url
    ENV["PGBACKUPS_URL"]
  end

  def client
    @client ||= PGBackups::Client.new(ENV["PGBACKUPS_URL"])
  end

  def databases
    if db = ENV["HEROKU_BACKUP_DATABASES"]
      db.split(",").map(&:strip)
    else
      ["DATABASE_URL"]
    end
  end

  def max_backups
    if max = ENV["HEROKU_BACKUP_MAXBACKUPS"]
      max.to_i
    else
      2
    end
  end

  def backup_name(to_url)
    # translate s3://bucket/email/foo/bar.dump => foo/bar
    parts = to_url.split('/')
    parts.slice(4..-1).join('/').gsub(/\.dump$/, '')
  end

  def make_room_for_new_backup
    backups = client.get_transfers.sort_by { |t| t["created_at"] }
    num_to_remove = backups.length - max_backups + databases.length

    if num_to_remove > 0
      log "too many backups (#{max_backups} max), purging #{num_to_remove} to make room"

      backups[0,num_to_remove].each do |backup|
        name = backup_name(backup["to_url"])
        log "  removing #{name}"
        client.delete_backup(name)
      end
    end
  end

  def execute
    log "starting heroku backup task"

    make_room_for_new_backup

    databases.each do |db|
      db_url = ENV[db]
      log "backing up: #{db}"
      client.create_transfer(db_url, db, nil, "BACKUP")
    end
  end

end; end

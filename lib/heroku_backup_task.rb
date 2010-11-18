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

  def backup_name(to_url)
    # translate s3://bucket/email/foo/bar.dump => foo/bar
    parts = to_url.split('/')
    parts.slice(4..-1).join('/').gsub(/\.dump$/, '')
  end

  def execute
    log "starting heroku backup task"

    databases.each do |db|
      db_url = ENV[db]
      log "backing up: #{db}"
      client.create_transfer(db_url, db, nil, "BACKUP", :expire => true)
    end
  end

end; end

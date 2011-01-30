$:.unshift File.expand_path("../lib", __FILE__)

require "rubygems"
require "heroku_backup_task/version"

Gem::Specification.new do |gem|
  gem.name     = "heroku_backup_task"
  gem.version  = HerokuBackupTask::VERSION

  gem.author   = "David Dollar"
  gem.email    = "ddollar@gmail.com"
  gem.homepage = "http://github.com/ddollar/heroku_backup_task"

  gem.summary  = "Automate your Heroku backups"

  gem.files = Dir["**/*"].select { |d| d =~ %r{^(README|bin/|data/|ext/|lib/|spec/|test/)} }

  gem.add_dependency "heroku", ">= 1.13.7"
  gem.add_dependency "rake"
end

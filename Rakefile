require 'fileutils'

require 'bundler'
Bundler.require

# loads the environment
env = ENV['RUBY_ENV'] ? ".env.#{ENV['RUBY_ENV']}" : '.env'
Dotenv.load(env)

# set up the DB
Sequel.extension :migration, :core_extensions
DB = Sequel.connect(ENV['DATABASE_URL'])

namespace :db do
  task :generate_migration do
    args = ARGV

    if args.size < 2
      puts 'You must provide a migration name'
      exit(1)
    elsif args.size > 2
      puts 'Ambiguous migration name'
      exit(1)
    end

    migration_name = args[1]

    file_name = Time.now.strftime("%Y%m%d%H%M%S") + "_" + migration_name
    path = './db/migrations/' + file_name + ".rb"

    migration_class = migration_name.split('_').collect(&:capitalize).join
    File.new(path, 'w') 

    File.open(path, 'w') do |f|
      f << "class #{migration_class} < Sequel::Migration\n"
      f << "  def up\n"
      f << "  end\n\n"
      f << "  def down\n"
      f << "  end\n"
      f << "end"
    end

    exit(1)
  end

  task :migrate do
    migrations_dir = './db/migrations'
    Sequel::TimestampMigrator.run(DB, migrations_dir, {})

    system("sequel -d '#{ENV['DATABASE_URL']}' > ./db/schema.rb") 
  end

  task :rollback do
    migrations_dir = './db/migrations'
    target = Sequel::TimestampMigrator.new(DB, migrations_dir).applied_migrations[-2].to_i
    Sequel::Migrator.run(DB, migrations_dir, target: target)

    system("sequel -d '#{ENV['DATABASE_URL']}' > ./db/schema.rb")
  end
end

require 'thor'

module Grails

  def self.project_root
    current_dir = Pathname.new(Dir.pwd)
    current_dir.ascend do |dir|
      gemfile = File.exist?(File.join(dir, 'Gemfile'))
      app_folder = Dir.exist?(File.join(dir, 'app'))
      return dir if gemfile && app_folder
    end
  end

  class Generator < Thor
    desc "migration NAME", "creates a migration file with name"
    def migration(name)
      file_name = name
      timestamp = Time.now.to_i
      path = File.join(project_root, "db/migrations/#{timestamp}_#{name}.sql")
      File.new(path, "w")

      puts "New migration file #{name} can be found at #{path}"
    end

    desc "model NAME", "creates model and migration files"
    def model(name)
      path = File.join(project_root, "app/models/#{name.underscore}.rb")
      raise "Model already exists" if File.exist?(path)

      File.open(path, "w") do |file|

      end

      migration(name)
      puts "New migration file #{name} can be found at #{path}"
    end

    def self.source_root
      File.dirname(__FILE__)
    end
  end


  class CLI < Thor
    desc "new", "'new' will generate a new Grails application in the working directory"

    def new(app_name)
      g = Generator.new
      g.directory "../lib", "./#{app_name.chomp}"
    end


    desc "generate COMMANDS "
  end
end

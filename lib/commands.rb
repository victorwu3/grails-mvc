require 'thor'
require 'pathname'
require 'fileutils'
require_relative 'version'


module Grails

  class Generate < Thor
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
        file.write("class #{name.camelcase} < GrailedORM::Base\n")
        file.write("   self.finalize!\n")
        file.write("end\n")
      end

      migration(name)
      puts "New migration file #{name} can be found at #{path}"
    end

    desc "controller NAME", "creates a controller file and view folder"
    def controller(name)
      controller_path = File.join(project_root, "app/controllers/#{file.pluralize.underscore}_controlller.rb")
      controller_name = "#{name.pluralize.camelcase}Controller"
      view_dir = File.join(project_root, "app/views/#{file.pluralize.underscore}")
      raise "Controller already exists" if File.exist?(controller_path)

      File.open(controller_path, "w") do |file|
        file.write("class #{controller_name} < ApplicationController\n")
        file.write("end")
      end
      Dir.mkdir(view_dir) unless Dir.exist?(view_dir)
      puts "New controller file #{name} can be found at #{controller_path}"
    end
  end

  class DB < Thor
    desc "reset", "resets the database and remigrates and reseeds"
    def reset
      DBConnection.reset
    end

    desc "seed", "seeds the database with seed file"
    def seed
      DBConnection.seed
    end

    desc "migrate", "runs all pending migrations if any"
    def migrate
      DBConnection.migrate
    end
  end

  class CLI < Thor
    desc "new", "'new' will generate a new Grails application in the working directory"

    def new(app_name)
      app_dir = File.join(Dir.pwd, app_name)
      Raise "Directory of #{app_name} already exists" if Dir.exist?(app_dir)
      FileUtils.copy_entry(TEMPLATE_PATH, app_dir)
      Dir.mkdir(File.join(app_dir, "app/models"))
      Dir.mkdir(File.join(app_dir, "db/migrations"))
      File.new(File.join(app_dir, "Gemfile"))

    end


    desc "generate COMMAND ...args", "Generates migration, model, or controller"
    subcommand "g", Generate

    desc "generate COMMAND ...args", "Generates migration, model, or controller"
    subcommand "generate", Generate

    desc "db COMMAND", "execute an action with the database"
    subcommand "db", DB

    desc "server", "starts a grails server, with default port of 3000"
    def server
      raise "Cannot find Grails app" unless project_root
      require_relative "#{project_root}/config/routes"
      require_relative '../bin/server'
      server = GrailsServer.new(3000)
      server.start
    end

  end
end

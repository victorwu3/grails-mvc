require 'fileutils'
require 'pathname'
require_relative 'version'


module Grails
  def self.project_root
    current_dir = Pathname.new(Dir.pwd)
    current_dir.ascend do |dir|
      gemfile = File.exist?(File.join(dir, 'Gemfile'))
      app_folder = Dir.exist?(File.join(dir, 'app'))
      return dir if gemfile && app_folder
    end
    nil
  end
end

GRAILS_ROOT = /^(.+)\/lib/.match(File.dirname(__FILE__))[1]
TEMPLATE_PATH = File.join(GRAILS_ROOT, 'template')
PROJECT_ROOT = Grails.project_root

require_relative "#{PROJECT_ROOT}/config/database" if PROJECT_ROOT
require_relative 'controller_base'
require_relative 'flash'
require_relative 'router'
require_relative 'session'
require_relative 'show_exceptions'
require_relative 'static'
require_relative 'commands'

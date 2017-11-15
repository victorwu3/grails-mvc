# -*- encoding: utf-8 -*-
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "version"

Gem::Specification.new do |spec|
  spec.name          = "grails-mvc"
  spec.version       = Grails::VERSION
  spec.authors       = ["Victor Wu"]
  spec.email         = ["victor.wu.1@vanderbilt.edu"]

  spec.summary       = %q{Grails is a lightweight MVC framework based on Rails!}
  spec.description   = %q{Build web applications easily with Grails!}
  spec.homepage      = "https://github.com/victorwu3/grails-mvc"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "https://rubygems.org"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0")
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "thor", "~> 0.20"
  spec.add_dependency "httparty", "~> 0.13"
  spec.add_dependency "rake", "~> 10.0"
  spec.add_dependency "sqlite3", "~> 1.3", ">= 1.3.5"
  spec.add_dependency "rack", "~> 1.6", ">= 1.6.4"
  spec.add_dependency "activesupport", "~> 4.2", ">= 4.2.5.2"

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "pry", "~> 0.10", ">= 0.10.3"
  spec.add_development_dependency "activesupport", "< 5.0"
end

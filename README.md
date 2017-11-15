# Grails::Mvc

Grails-mvc is a lightweight MVC framework based on Rails written in Ruby. GrailedORM, a custom version of Active Record, is implemented in conjunction.



## Installation

Add this line to your application's Gemfile:

```ruby
gem 'grails-mvc'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install grails-mvc

## Features
- GrailedORM - Custom ORM to create associations between objects
- Thor - create command line methods for Grails
- Server - Utilizes Rack to make server requests and build responses
- Router - Builds RESTful routes to the controllers
- Session - stores and receives session data from the cookies
- Flash - stores and receives error messages from the cookies

## Usage

To start a new project run this command in the desired directory:

    $ grails new { PROJECT NAME }

To generate models, controllers, and migrations, use the keyword generate like so:

    $ grails generate migration { MIGRATION NAME }

    $ grails generate model { MODEL NAME }    

    $ grails generate controller { CONTROLLER NAME }

To setup the database:

    $ grails db reset  - clears database, remigrates and reseeds

    $ grails db migrate - runs any pending migrations

    $ grails db seed - seeds database

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/grails-mvc. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Grails::Mvc project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/grails-mvc/blob/master/CODE_OF_CONDUCT.md).

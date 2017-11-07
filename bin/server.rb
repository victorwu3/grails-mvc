require 'rack'
require_relative '../lib/controller_base.rb'
require_relative '../lib/router'
require_relative '../lib/static'
require_relative '../lib/show_exceptions'

attr_reader :port, :host
class GrailsServer
  def initialize(port)
    @port = port
    router = Router.new
    router.draw(&ROUTES)

    grails_app = Proc.new do |env|
      req = Rack::Request.new(env)
      res = Rack::Response.new
      res['Content-Type'] = "text/text"
      res.write(req.path)
      router.run(req, res)
      res.finish
    end

    @app = Rack::Builder.new do
      use Static
      use ShowExceptions
      run grails_app
    end
  end


  def start
    Rack::Server.start(
      app: @app,
      Port: 3000
    )
  end


end

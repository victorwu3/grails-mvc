require 'rack'

attr_reader :port, :host
class GrailsServer
  def initialize(port, host)
    @port = port
    @host = host
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
      Port: 3000,
      Host: host
    )
  end


end

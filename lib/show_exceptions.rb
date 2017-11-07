require 'erb'

class ShowExceptions
  def initialize(app)
    @app = app
  end

  def call(env)
    app.call(env)
  rescue Exception => e
    puts e
  end

  private

  def render_exception(e)
    
  end

end

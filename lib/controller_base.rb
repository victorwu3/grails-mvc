require 'active_support'
require 'active_support/core_ext'
require 'erb'
require_relative './session'
require_relative './flash'
require 'active_support/inflector'

Module GrailsController
  class Base
    attr_reader :req, :res, :params

    def initialize(req, res, params = {})
      @req = req
      @res = res
      @params = params.merge(req.params)
    end

    def already_built_response?
      @already_built_response
    end

    def redirect_to(url)
      raise 'Already rendered' if already_built_response?
      @already_built_response = true
      @res.set_header('Location', url)
      @res.status = 302
      session.store_session(@res)
    end

    def render_content(content, content_type)
      raise 'Already rendered' if already_built_response?
      @already_built_response = true
      @res['Content-Type'] = content_type
      @res.write(content)
      session.store_session(@res)
    end

    def render(template_name)
      content = ERB.new(File.read("views/#{self.class.name.underscore}/#{template_name}.html.erb")).result(binding)
      render_content(content, 'text/html')
    end

    def session
      @session ||= Session.new(@req)
    end

    def invoke_action(name)
      self.send(name)
      render(name) unless already_built_response?
    end
  end
end

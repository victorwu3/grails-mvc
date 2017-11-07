require 'json'

class Flash

  def initialize(req)
    cookie = req.cookies['flash']

    @now = cookie ? JSON.parse(cookie) : {}
    @flash = {}
  end

  def store_flash(res)
    res.set_cookie('flash', { path: '/', value: @flash.to_json })
  end

  def [](key)
    @now[key.to_s] || @flash[key.to_s]
  end

  def []=(key, value)
    @flash[key.to_s] = value
end

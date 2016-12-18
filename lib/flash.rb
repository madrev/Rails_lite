require 'json'

class Flash
  attr_reader :now

  def initialize(req)
    cookie = req.cookies["_rails_lite_app_flash"]
    @now = (cookie.nil? ? {} : JSON.parse(cookie))
    @flash = {}
  end

  def [](key)
    @flash[key.to_s] || @now[key.to_s]
  end

  def []=(key, val)
    @flash[key] = val
  end


  def store_flash(res)
    cookie_hash = { path: "/", value: @flash.to_json }
    res.set_cookie("_rails_lite_app_flash", cookie_hash)
  end
end

require 'json'

class Flash
  def initialize(req)
    cookie = req.cookies["_rails_lite_app_flash"]
    @flash = (cookie.nil? ? {} : JSON.parse(cookie))
    @next_flash = {}
  end

  def [](key)
    @flash[key.to_s]
  end

  def []=(key, val)
    @flash[key] = val
  end

  def store_flash(res)
    cookie_hash = { path: "/", value: @flash.to_json }
    res.set_cookie("_rails_lite_app_flash", cookie_hash)
  end
end

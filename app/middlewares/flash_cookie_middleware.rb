require 'rack/utils'

class FlashCookieMiddleware
  def initialize(app, cookie_key = 'auth_token')
    @app = app
    @cookie_key = cookie_key
  end

  def call(env)
    if env['HTTP_USER_AGENT'] =~ /^(Adobe|Shockwave) Flash/
      params = ::Rack::Utils.parse_query(env['QUERY_STRING'])
      env['HTTP_COOKIE'] = [ 'auth_token', params['auth_token'] ].join('=').freeze unless params['auth_token'].nil?
    end
    @app.call(env)
  end
end
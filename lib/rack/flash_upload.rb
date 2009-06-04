module Merb
  module Rack
    class SetSessionCookieFromFlash < Merb::Rack::Middleware
      # :api: private
      def initialize(app, session_key = '_session_id')
        super(app)
        @session_key = session_key
      end
      # :api: plugin
      def call(env)
        if env["HTTP_USER_AGENT"] =~ /^(Adobe|Shockwave) Flash/
          params = Merb::Parse.query(env['QUERY_STRING'])
          if params[@session_key]
            env['HTTP_COOKIE'] = [@session_key, params[@session_key]].join('=').freeze
          end
        end
        @app.call(env)
      end
    end
  end
end
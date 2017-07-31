module BG
  module Common
    module Middlewares
      class BasicAuth
        def initialize app
          @app = app
        end

        def call env
          if ENV['BASIC_AUTH_ENABLED'] == 'true'
            auth = Rack::Auth::Basic.new(@app) do |u, p|
              u == username && p == password
            end

            auth.call env
          else
            @status, @headers, @response = @app.call(env)
            [@status, @headers, @response]
          end
        end

        def username
          ENV['BASIC_AUTH_USERNAME']
        end

        def password
          ENV['BASIC_AUTH_PASSWORD']
        end
      end
    end
  end
end

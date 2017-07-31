module BG
  module Common
    class Railtie < Rails::Railtie
      initializer 'bg.common.configure_rails_initialization' do
        Rails.application.middleware.use BG::Common::Middlewares::BasicAuth
      end
    end
  end
end

require_relative 'analytics/tracker'

module BG
  module Common
    module Analytics
      class << self
        def load!
          load_ga       if ga?
          load_intercom if intercom?
        end

        def ga?
          defined?(::Gabba) && ENV['GA_TRACKER_CODE'] && ENV['GA_DOMAIN']
        end

        def intercom?
          defined?(::Intercom)
        end

        private

        def load_ga
          require_relative 'analytics/ga'
        end

        def load_intercom
          require_relative 'analytics/intercom'
        end
      end
    end
  end
end

BG::Common::Analytics.load!

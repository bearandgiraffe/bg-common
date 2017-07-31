require_relative 'analytics/tracker'

module BG
  module Common
    module Analytics
      class << self
        def load!
          load_ga       if ga?
          load_intercom if intercom?
          load_keen     if keen?
        end

        def ga?
          defined?(::Gabba) && ENV['GA_TRACKER_CODE'] && ENV['GA_DOMAIN']
        end

        def intercom?
          defined?(::Intercom)
        end

        def keen?
          defined?(::Keen)
        end

        private

        def load_ga
          require_relative 'analytics/ga'
        end

        def load_intercom
          require_relative 'analytics/intercom'
        end

        def load_keen
          require_relative 'analytics/keen'
        end
      end
    end
  end
end

BG::Common::Analytics.load!

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
          begin
            require 'gabba'
            defined?(::Gabba) && ENV['GA_TRACKER_CODE'] && ENV['GA_DOMAIN']
          rescue LoadError
            BG::Common.logger.info 'GA is not loaded'

            return false
          end
        end

        def intercom?
          begin
            require 'intercom'
            defined?(::Intercom) && ENV['INTERCOM_ACCESS_TOKEN']
          rescue LoadError
            BG::Common.logger.info 'Intercom is not loaded'

            return false
          end
        end

        def keen?
          begin
            require 'keen'
            defined?(::Keen) && ENV['KEEN_PROJECT_ID']
          rescue LoadError
            BG::Common.logger.info 'Keen is not loaded'

            return false
          end
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

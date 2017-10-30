module BG
  module Common
    module Analytics
      module GA
        class Client
          def initialize
            @ga = ::Gabba::Gabba.new(ENV['GA_TRACKER_CODE'], ENV['GA_DOMAIN'])
          end

          def ga
            @ga ||= ::Gabba::Gabba.new(ENV['GA_TRACKER_CODE'], ENV['GA_DOMAIN'])
          end

          def self.call data
            self.new.call data
          end

          def call data
            ga.event(
              data[:category],
              data[:action],
              data[:label],
              data[:value],
              data[:bounce] || false
            )
          end
        end
      end
    end
  end
end

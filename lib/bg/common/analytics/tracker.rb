module BG
  module Common
    module Analytics
      class Tracker
        def initialize data
          @data = data
        end

        def call
          if Analytics.ga? and @data[:ga]
            GA.create_event @data[:ga]
          end

          if Analytics.intercom? and @data[:intercom]
            Intercom.create_event @data[:intercom]
          end

          if Analytics.keen? and @data[:keen]
            Keen.create_event @data[:keen][:event], @data[:keen][:data]
          end
        end
      end
    end
  end
end

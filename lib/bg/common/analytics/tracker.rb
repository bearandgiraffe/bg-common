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
        end
      end
    end
  end
end

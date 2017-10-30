module BG
  module Common
    module Analytics
      class Tracker
        def initialize
        end

        def self.call data
          self.new.call data
        end

        def call data
          if BG::Common::Analytics.ga? and data[:ga]
            BG::Common::Analytics::GA.create_event data[:ga]
          end

          if BG::Common::Analytics.intercom? and data[:intercom]
            BG::Common::Analytics::Intercom.create_event data[:intercom]
          end

          if BG::Common::Analytics.keen? and data[:keen]
            BG::Common::Analytics::Keen.create_event data[:keen][:event], data[:keen][:data]
          end
        end
      end
    end
  end
end

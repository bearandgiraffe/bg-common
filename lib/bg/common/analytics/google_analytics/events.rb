#
# Module that wraps the GA events API to create specific events related
# to actions from the app.
#
module BG
  module Common
    module Analytics
      module GA
        module Events
          #
          # Creates an event in GA
          #
          # @param data, Hash
          #
          # The data param includes the information for the event to register on GA.
          # It should have the following attributes:
          #
          # category: String
          # action:   String
          # label:    String
          # value:    Integer
          # bounce:   Boolean
          #
          # more info here:
          # https://support.google.com/analytics/answer/1033068#Anatomy
          # https://developers.google.com/analytics/devguides/collection/analyticsjs/events
          #
          def create_event data
            if BG::Common.active_job?
              GAEventJob.perform_later data
            else
              Client.new.call data
            end
          end
        end
      end
    end
  end
end


#
# Module that wraps the Intercom events API to create specific
# events related to app actions.
#
module BG
  module Common
    module Analytics
      module Intercom
        module Events
          #
          # Creates an event in Intercom
          #
          # @param data, Hash
          #
          # The data param includes the information for the event to register on
          # Intercom. It should have the following attributes:
          #
          # event_name: String
          # created_at: Timestamp
          # email:      String
          # metadata:   Object
          #
          # more info here: https://doc.intercom.io/api/#submitting-events
          #
          def create_event data
            if BG::Common.active_job?
              IntercomEventJob.perform_later data
            else
              BG::Common::Analytics::Intercom::Client.new.call data
            end
          end
        end
      end
    end
  end
end

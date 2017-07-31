#
# Module that wraps the Keen events API to create specific
# events related to app actions.
#
module BG
  module Common
    module Analytics
      module Keen
        module Events
          #
          # Creates an event in Keen
          #
          # @param data, Hash
          #
          # The data param includes the information for the event to register on
          # Keen. It can be any valid Ruby hash.
          #
          # more info here: https://github.com/keenlabs/keen-gem#synchronous-publishing
          #
          def create_event event, data
            if BG::Common.active_job?
              KeenEventJob.perform_later event, data
            else
              Client.new.call event, data
            end
          end
        end
      end
    end
  end
end

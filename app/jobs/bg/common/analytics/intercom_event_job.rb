module BG
  module Common
    module Analytics
      class IntercomEventJob < ::ActiveJob::Base
        queue_as :analytics

        def perform data
          Intercom::Client.new.call data
        end
      end
    end
  end
end

module BG
  module Common
    module Analytics
      class IntercomEventJob < ::ActiveJob::Base
        queue_as :analytics

        def perform data
          BG::Common::Analytics::Intercom::Client.call data
        end
      end
    end
  end
end

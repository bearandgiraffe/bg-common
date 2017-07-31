module BG
  module Common
    module Analytics
      class KeenEventJob < ::ActiveJob::Base
        queue_as :analytics

        def perform event, data
          Keen::Client.new.call event, data
        end
      end
    end
  end
end

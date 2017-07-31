module BG
  module Common
    module Analytics
      class GAEventJob < ::ActiveJob::Base
        queue_as :analytics

        def perform data
          GA::Client.new.call data
        end
      end
    end
  end
end

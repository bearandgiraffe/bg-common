require 'bg/common/analytics'

module BG
  module Common
    module Analytics
      class GAEventJob < ::ActiveJob::Base
        queue_as :analytics

        def perform data
          BG::Common::Analytics::GA::Client.call data
        end
      end
    end
  end
end

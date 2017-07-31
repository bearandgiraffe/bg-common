require_relative 'google_analytics/client'
require_relative 'google_analytics/events'

module BG
  module Common
    module Analytics
      module GA
        extend Events
      end
    end
  end
end

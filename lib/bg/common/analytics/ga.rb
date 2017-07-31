require_relative 'google_analytics/base'
require_relative 'google_analytics/events'

module BG
  module Common
    module Analytics
      module GA
        extend Base
        extend Events
      end
    end
  end
end

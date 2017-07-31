require_relative 'keen/client'
require_relative 'keen/events'

module BG
  module Common
    module Analytics
      module Keen
        extend Events
      end
    end
  end
end

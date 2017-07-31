require_relative 'intercom/client'
require_relative 'intercom/user'
require_relative 'intercom/events'

module BG
  module Common
    module Analytics
      module Intercom
        extend User
        extend Events
      end
    end
  end
end

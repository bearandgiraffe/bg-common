require_relative 'intercom/base'
require_relative 'intercom/user'
require_relative 'intercom/events'

module BG
  module Common
    module Analytics
      module Intercom
        extend Base
        extend User
        extend Events
      end
    end
  end
end

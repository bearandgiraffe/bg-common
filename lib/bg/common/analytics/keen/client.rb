module BG
  module Common
    module Analytics
      module Keen
        class Client
          def initialize
          end

          def call event, data = {}
            ::Keen.publish event.to_sym, data
          end
        end
      end
    end
  end
end

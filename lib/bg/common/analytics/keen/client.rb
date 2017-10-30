module BG
  module Common
    module Analytics
      module Keen
        class Client
          def initialize
          end

          def self.call event, data = {}
            self.new.call event, data
          end

          def call event, data = {}
            ::Keen.publish event.to_sym, data
          end
        end
      end
    end
  end
end
